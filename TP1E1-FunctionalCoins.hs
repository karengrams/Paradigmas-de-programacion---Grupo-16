--------------------------------------
-- FUNCTIONAL COINS - TP1 Entrega 1 --
--            GRUPO 16              --
--------------------------------------

{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec

data Billetera = Billetera {
nombre :: String,
dinero :: Float
} deriving (Show, Eq)

type Evento = Billetera -> Billetera
type Transaccion = Billetera -> Evento

--------------------
--  BILLETERAS    --
--------------------

pepe = Billetera "Jose" 10 
pepe2 = Billetera "Jose" 20
pepe3 = Billetera "Jose" 50
lucho = Billetera "Luciano" 2

--------------------
--    TESTING     --
--------------------

probarFunciones = hspec $ do
  describe "Testings aplicados a una billetera de 10 monedas:" $ do
   it " 1- Despues de depositarle 10 monedas, la billetera cuenta con 20 monedas." $ dinero (depositar 10 (Billetera "Una Billetera De 10" 10)) `shouldBe` 20 
   it " 2- Despues de extraer 3 monedas, la billetera cuenta con 7 monedas." $ dinero (extraer (3) (Billetera "Una Billetera De 10" 10)) `shouldBe` 7
   it " 3- Despues de extraer 15 monedas, la billetera cuenta con 0 monedas." $ dinero(extraer (15) (Billetera "Una Billetera De 10" 10)) `shouldBe` 0
   it " 4- Despues de un upgrade, la billetera cuenta con 12 monedas." $ dinero (upgrade (Billetera "Una Billetera De 10" 10)) `shouldBe` 12
   it " 5- Cuando se cierra la cuenta, la billetera cuenta con 0 monedas." $ dinero (cerrarCuenta (Billetera "Una Billetera De 10" 10)) `shouldBe` 0
   it " 6- La billetera cuenta con 10 monedas." $ do dinero(quedaIgual((Billetera "Una Billetera De 10" 10))) `shouldBe` 10
   it " 7- Luego de depositar 1000 monedas y realizarle un upgrade, la billetera cuenta con 1020 monedas." $ dinero((upgrade.depositar (1000)) (Billetera "Una Billetera De 10" 10)) `shouldBe` 1020
  describe "Testings de las operaciones aplicados a las billeteras de Lucho y Pepe:" $ do
   it " 8- La billetera de Pepe cuenta con 10 monedas" $ dinero pepe `shouldBe` 10
   it " 9- La billetera de Pepe, luego de su cierre, cuenta con 0 monedas." $ dinero (cerrarCuenta(pepe)) `shouldBe` 0
   it "10- La billetera de Pepe, luego de depositarle 15, extrarle 2 y un upgrade, cuenta con 27,6 monedas." $ dinero((upgrade.extraer(2).depositar(15)) pepe) `shouldBe` 27.6
  describe "Testings de las transacciones aplicadas a Pepe y Lucho:" $ do
   it "11- Se aplica la transaccion uno a Pepe y el resultado se aplica a una billetera con 20 monedas, quedando igual." $ dinero ((transaccionUno "Luciano" pepe) (Billetera "Una Billetera De 20" 20)) `shouldBe` 20
   it "12- Se aplica la transaccion dos a Pepe y el resultado se aplica a una billetera con 10 monedas, quedando con 15 monedas." $ dinero ((transaccionDos "Jose" pepe)(Billetera "Una Billetera De 10" 10)) `shouldBe` 15
   it "13- Se aplica la transaccion dos a Pepe 2 (quien cuenta con 20 monedas) y el resultado se aplica a una billetera con 50 monedas, quedando con 55 monedas." $ dinero((transaccionDos "Jose" (pepe2)) (Billetera "Una Billetera De 50" 50)) `shouldBe` 55
  describe "Testings de nuevos eventos, modificando el dinero de la billetera de Lucho (su dinero ahora es de 10 monedas):" $ do
   it "14- Se aplica la transaccion tres a Lucho y el resultado se aplica a una billetera con 10 monedas, quedando con 0 monedas." $ dinero((transaccionTres "Luciano" lucho) (Billetera "Una Billetera De 10" 10)) `shouldBe` 0
   it "15- Se aplica la transaccion cuatro a Lucho y el resultado se aplica a una billetera con 10 monedas,quedando con 34 monedas." $ dinero((transaccionCuatro "Luciano" lucho) (Billetera "Una Billetera De 10" 10)) `shouldBe` 34
  describe "Testings de pago entre usuarios:" $ do
   it "16- Se aplica la transaccion cinco en Pepe y el resultado se aplica en una billetera de 10 monedas, quedando con 3 monedas." $ dinero((transaccionCinco "Jose" "Un nombre X" pepe) (Billetera "Una Billetera De 10" 10)) `shouldBe` 3
   it "17- Se aplica la transaccion cinco a Lucho y el resultado se aplica en una billetera de 10 monedas, quedando con 17 monedas." $ dinero((transaccionCinco "Un nombre X" "Luciano" lucho)(Billetera "Una Billetera De 10" 10)) `shouldBe` 17


--------------------
--    EVENTOS     --
--------------------

sinDinero :: Evento
sinDinero billetera = billetera { dinero = 0 }

nuevoDinero :: Float -> Evento
nuevoDinero nuevoMonto billetera = billetera { dinero = nuevoMonto }

depositar :: Float -> Evento
depositar dineroDepositado billetera = billetera {dinero = (dinero billetera + dineroDepositado)}

extraer :: Float -> Evento
extraer dineroExtraido billetera
  | dinero billetera - dineroExtraido <=0  = sinDinero billetera
  | otherwise                              = billetera { dinero = (dinero billetera - dineroExtraido)}

upgrade :: Evento
upgrade billetera = billetera {dinero = (dinero billetera + (min) 10 (0.20 * dinero billetera))}

cerrarCuenta :: Evento
cerrarCuenta billetera = sinDinero billetera

tocoYMeVoy :: Evento
tocoYMeVoy billetera = (cerrarCuenta . upgrade . depositar 15) billetera

ahorranteErrante :: Evento
ahorranteErrante billetera = (depositar 10 . upgrade . depositar 8 . extraer (1) . depositar 2 . depositar 1) billetera

quedaIgual ::Evento
quedaIgual billetera = billetera

--------------------
-- TRANSACCIONES  --
--------------------

transaccionUno :: String -> Billetera -> Evento
transaccionUno nombreAComparar billetera | nombre billetera == nombreAComparar =  cerrarCuenta
                                         | otherwise                           = quedaIgual

transaccionDos :: String -> Billetera -> Evento
transaccionDos nombreAComparar billetera | nombre billetera == nombreAComparar =  (depositar 5)
                                         | otherwise                           = quedaIgual

transaccionTres :: String -> Billetera -> Evento
transaccionTres nombreAComparar billetera | nombre billetera == nombreAComparar =  tocoYMeVoy
                                          | otherwise                           = quedaIgual

transaccionCuatro :: String -> Billetera -> Evento
transaccionCuatro nombreAComparar billetera | nombre billetera == nombreAComparar =  ahorranteErrante
                                            | otherwise                           = quedaIgual

transaccionCinco :: String -> String -> Billetera -> Evento
transaccionCinco nombreAExtraer nombreADepositar billetera | nombre billetera == nombreAExtraer    = extraer (7)
                                                           | nombre billetera == nombreADepositar  = depositar (7)
                                                           | otherwise                             = quedaIgual

------------------------------
-- TRANSACCIONES ESCALABLES --
------------------------------

transaccion :: String -> Evento -> Billetera -> Evento
transaccion nombreAComparar eventoAAplicar billeteraAComparar | nombre billeteraAComparar == nombreAComparar = eventoAAplicar
                                                              | otherwise                                    = quedaIgual

transferencia :: String -> String -> Float -> Billetera -> Evento
transferencia nombreEmisor nombreDestinatario montoADepositar billeteraAComparar | montoADepositar < 0 = error "No se puede depositar un monto negativo"
                                                                                 | nombre billeteraAComparar == nombreEmisor = extraer (-montoADepositar)
                                                                                 | nombre billeteraAComparar == nombreDestinatario = depositar (montoADepositar)
                                                                                 | otherwise = quedaIgual

