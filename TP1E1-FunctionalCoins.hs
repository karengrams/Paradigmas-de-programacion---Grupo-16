-- Functional Coins - Entrega 1
-- Grupo 16

{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec

data Billetera = Billetera {
nombre :: String,
dinero :: Float
} deriving (Show, Eq)

pepe = Billetera "José" 10 
pepe2 = Billetera "José" 20
pepe3 = Billetera "José" 50
lucho = Billetera "Luciano" 2

probarFunciones = hspec $ do
  describe "Testings aplicados a una billetera de 10 monedas:" $ do
   it "Despues de depositarle 10 monedas, la billetera cuenta con 20 monedas." $ dinero (depositar 10 pepe) `shouldBe` 20
   it "Despues de extraer 3 monedas, la billetera cuenta con 7 monedas." $ dinero (extraer (-3) pepe) `shouldBe` 7
   it "Despues de extraer 15 monedas, la billetera cuenta con 0 monedas." $ dinero(extraer (-15) pepe) `shouldBe` 0
   it "Despues de un upgrade, la billetera cuenta con 12 monedas." $ dinero (upgrade pepe) `shouldBe` 12
   it "Cuando se cierra la cuenta, la billetera cuenta con 0 monedas." $ dinero (cerrarCuenta pepe) `shouldBe` 0
   it "La billetera cuenta con 10 monedas." $ do dinero(quedaIgual(pepe)) `shouldBe` 10
   it "Luego de depositar 1000 monedas y realizarle un upgrade, la billetera cuenta con 1020 monedas." $ dinero((upgrade.depositar(1000)) pepe) `shouldBe` 1020
  describe "Testings de las operaciones aplicados a las billeteras de Lucho y Pepe:" $ do
   it "La billetera de Pepe cuenta con 10 monedas" $ do dinero pepe `shouldBe` 10
   it "La billetera de Pepe, luego de su cierre, cuenta con 0 monedas." $ do dinero (cerrarCuenta(pepe)) `shouldBe` 0
   it "La billetera de Pepe, luego de depositarle 15, extrarle 2 y un upgrade, cuenta con 27,6 monedas." $ do dinero((upgrade.extraer(-2).depositar(15)) pepe) `shouldBe` 27.6
  describe "Testings de las transacciones aplicadas a Pepe y Lucho:" $ do
   it "Se aplica la transaccion uno a Pepe, su billetera cuenta con 10 monedas." $ do dinero (transaccionUno pepe) `shouldBe` 10
   it "Se aplica la transaccion dos a Pepe, su billetera cuenta con 15 monedas." $ do dinero (transaccionDos pepe) `shouldBe` 15
   it "Se aplica la transaccion dos a Pepe 2 (quien cuenta con 20 monedas), su billetera cuenta con 25 monedas." $ do dinero(transaccionDos(pepe2)) `shouldBe` 25
   it "Se aplica la transaccion dos a Pepe 3 (quien cuenta con 50 monedas), su billetera cuenta con 55." $ do dinero(transaccionDos(pepe3)) `shouldBe` 55
  describe "Testings de nuevos eventos, modificando el dinero de la billetera de Lucho (su dinero ahora es de 10 monedas):" $ do
   it "Se aplica la transaccion tres a Lucho, su billetera cuenta con 0 monedas." $ do dinero(transaccionTres(nuevoDinero 10 lucho)) `shouldBe` 0
   it "Se aplica la transaccion cuatro a Lucho, su billetera cuenta con 34 monedas." $ do dinero((ahorranteErrante.nuevoDinero 10) lucho) `shouldBe` 34
  describe "Testings de pago entre usuarios:" $ do
   it "Se aplica la transaccion cinco en Pepe, su billetera cuenta con 3 monedas." $ do dinero(transaccionCinco pepe) `shouldBe` 3
   it "Se aplica la transaccion cinco a Lucho, su billeter cuenta con 17." $ do dinero((transaccionCinco.nuevoDinero 10) lucho) `shouldBe` 17


type Evento = Billetera -> Billetera

sinDinero billetera = billetera { dinero = 0 }

nuevoDinero :: Float -> Evento
nuevoDinero nuevoMonto billetera = billetera { dinero = nuevoMonto }

depositar :: Float -> Evento
depositar dineroDepositado billetera = billetera {dinero = (dinero billetera + dineroDepositado)}

extraer :: Float -> Evento
extraer dineroExtraido billetera
  | dinero billetera + dineroExtraido <=0 = sinDinero billetera
  | otherwise = billetera { dinero = (dinero billetera + dineroExtraido)}


upgrade billetera = billetera {dinero = (dinero billetera + (min) 10 (0.20 * dinero billetera))}


cerrarCuenta :: Evento
cerrarCuenta billetera = sinDinero billetera

quedaIgual ::Evento
quedaIgual billetera = billetera

transaccionUno :: Evento
transaccionUno billetera | nombre billetera == "Luciano" =  cerrarCuenta billetera
                         | otherwise = quedaIgual billetera

transaccionDos :: Evento
transaccionDos billetera | nombre billetera == "José" =  (depositar 5) billetera
                         | otherwise = quedaIgual billetera

{-
type Transaccion = String -> Evento -> Evento

transaccion :: Transaccion
transaccion nombreAComparar eventoAAplicar billeteraAfectada | nombre billeteraAfectada == nombreAComparar = eventoAAplicar billeteraAfectada
                                                                    | otherwise = quedaIgual billeteraAfectada
-}

tocoYMeVoy :: Evento
tocoYMeVoy billetera = (cerrarCuenta . upgrade . depositar 15) billetera

ahorranteErrante :: Evento
ahorranteErrante billetera = (depositar 10 . upgrade . depositar 8 . extraer (-1) . depositar 2 . depositar 1) billetera


transaccionTres :: Evento
transaccionTres billetera | nombre billetera == "Luciano" =  tocoYMeVoy billetera
                          | otherwise = quedaIgual billetera

transaccionCuatro :: Evento
transaccionCuatro billetera | nombre billetera == "Luciano" =  ahorranteErrante billetera
                            | otherwise = quedaIgual billetera

transaccionCinco billetera | nombre billetera == "José"    = extraer (-7) billetera
                           | nombre billetera == "Luciano" = depositar (7) billetera
                           | otherwise                     = quedaIgual billetera
