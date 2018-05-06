--------------------------------------
-- FUNCTIONAL COINS - TP1 Entrega 1 --
--            GRUPO 16              --
--------------------------------------

{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec

type Dinero = Float
type SaldoBilletera = Dinero
type Nombre = String
type Evento = SaldoBilletera -> SaldoBilletera
type Operacion = Usuario -> Evento
type Bloque = [Usuario -> SaldoBilletera -> SaldoBilletera]
type BlockChain = [Bloque]

data Usuario = Usuario {
nombre :: String,
saldoBilletera :: SaldoBilletera
} deriving (Show, Eq)


--------------------
--  USUARIOS    --
--------------------

pepe = Usuario "Jose" 10 
pepe2 = Usuario "Jose" 20
pepe3 = Usuario "Jose" 50
lucho = Usuario "Luciano" 2

--------------------
--    TESTING     --
--------------------

probarFunciones = hspec $ do
  describe "Primera entrega nro. 1:" $ do
  describe "Testings aplicados a una billetera de 10 monedas:" $ do
   it " 1- Despues de depositarle 10 monedas, la billetera cuenta con 20 monedas." $ depositar 10 10 `shouldBe` 20 
   it " 2- Despues de extraer 3 monedas, la billetera cuenta con 7 monedas." $ extraer 3 10 `shouldBe` 7
   it " 3- Despues de extraer 15 monedas, la billetera cuenta con 0 monedas." $ extraer 15 10 `shouldBe` 0
   it " 4- Despues de un upgrade, la billetera cuenta con 12 monedas." $ upgrade 10 `shouldBe` 12
   it " 5- Cuando se cierra la cuenta, la billetera cuenta con 0 monedas." $ cerrarCuenta 10 `shouldBe` 0
   it " 6- La billetera cuenta con 10 monedas." $ do quedaIgual 10 `shouldBe` 10
   it " 7- Luego de depositar 1000 monedas y realizarle un upgrade, la billetera cuenta con 1020 monedas." $ (upgrade.depositar 1000) 10 `shouldBe` 1020
  describe "Testings de las operaciones aplicados a las billeteras de Lucho y Pepe:" $ do
   it " 8- La billetera de Pepe cuenta con 10 monedas" $ saldoBilletera pepe `shouldBe` 10
   it " 9- La billetera de Pepe, luego de su cierre, cuenta con 0 monedas." $ (cerrarCuenta.saldoBilletera) pepe `shouldBe` 0
   it "10- La billetera de Pepe, luego de depositarle 15, extrarle 2 y un upgrade, cuenta con 27,6 monedas." $ (upgrade.extraer(2).depositar(15).saldoBilletera) pepe `shouldBe` 27.6
  describe "Testings de las transacciones aplicadas a Pepe y Lucho:" $ do
   it "11- Se aplica la transaccion uno a Pepe y el resultado se aplica a una billetera con 20 monedas, quedando igual." $ transaccion "Luciano" cerrarCuenta pepe 20 `shouldBe` 20
   it "12- Se aplica la transaccion dos a Pepe y el resultado se aplica a una billetera con 10 monedas, quedando con 15 monedas." $ transaccion "Jose" (depositar 5) pepe 10 `shouldBe` 15
   it "13- Se aplica la transaccion dos a Pepe 2 (quien cuenta con 20 monedas) y el resultado se aplica a una billetera con 50 monedas, quedando con 55 monedas." $ transaccion "Jose" (depositar 5) pepe2 50 `shouldBe` 55
  describe "Testings de nuevos eventos, modificando el dinero de la billetera de Lucho (su dinero ahora es de 10 monedas):" $ do
   it "14- Se aplica la transaccion tres a Lucho y el resultado se aplica a una billetera con 10 monedas, quedando con 0 monedas." $ transaccion "Luciano" tocoYMeVoy lucho 10 `shouldBe` 0
   it "15- Se aplica la transaccion cuatro a Lucho y el resultado se aplica a una billetera con 10 monedas,quedando con 34 monedas." $ transaccion "Luciano" ahorranteErrante lucho 10 `shouldBe` 34
  describe "Testings de pago entre usuarios:" $ do
   it "16- Se aplica la transaccion cinco en Pepe y el resultado se aplica en una billetera de 10 monedas, quedando con 3 monedas." $ transferencia "Jose" "Luciano" 7 pepe 10 `shouldBe` 3
   it "17- Se aplica la transaccion cinco a Lucho y el resultado se aplica en una billetera de 10 monedas, quedando con 17 monedas." $ transferencia "Jose" "Luciano" 7 lucho 10 `shouldBe` 17
  describe "Segunda entrega nro. 2:" $ do
   --it "18- "
   --it "19- "
   --it "20- "
   it "21- Se aplica el bloque 1 a Pepe y el resultado es un usuario con una billetera de 18." $ impactarBloque bloqueUno pepe `shouldBe` Usuario "Jose" 18
   it "22- Se determina quienes son los usuarios con un saldo mayor a 10, se deberia mostrar a Pepe con su saldo original y no se deberia mostrar a Luciano." $ do quienesQuedanConAlMenos 10 bloqueUno [pepe,lucho] `shouldBe` [pepe]
   it "23- Se determina quien es el mas adinerado, aplicandole a una lista con Pepe y Lucho, quedaria Pepe." $ do elMasAdineradoLuegoDeBloque bloqueUno [lucho,pepe] `shouldBe` pepe
   it "24- Se determina quien es el menos adinerado, aplicandole a una lista con Pepe y Lucho, quedaria Lucho." $ do elMenosAdineradoLuegoDeBloque bloqueUno [lucho,pepe] `shouldBe` lucho
   it "25- Se determina cual es el peor bloque, aplicandolo a el BlockChain definido y a Pepe, deberia quedar Pepe con una billetera de 18." $ do impactarBloque (peorBloqueDelBlockChain pepe blockChain) pepe `shouldBe` Usuario "Jose" 18
   it "26- Se aplica el BlockChain definido a Pepe, deberia quedar Pepe con un saldo de 115." $ do impactarBlockChain blockChain pepe `shouldBe` Usuario "Jose" 115
   it "27- Se aplica el BlockChain hasta 3 a Pepe, deberia quedar Pepe con un saldo de 51." $ do  saldoHastaN 3 blockChain pepe `shouldBe` Usuario "Jose" 51
   it "28- Se aplica el BlockChain a Pepe y a Lucho, la sumatoria de sus saldos deberia ser de 115." $ do  (sum . map saldoBilletera) (aplicacionDeBlockChainAUsuarios blockChain [pepe,lucho]) `shouldBe` 115

--------------------
--    EVENTOS     --
--------------------

nuevoDinero :: Evento
nuevoDinero nuevoMonto = nuevoMonto

depositar :: Dinero -> Evento
depositar dineroDepositado = (+) dineroDepositado

extraer :: Dinero -> Evento
extraer dineroExtraido billetera = (max) 0 (billetera - dineroExtraido)

upgrade :: Evento
upgrade saldoBilletera = saldoBilletera + (min) 10 (0.20 * saldoBilletera)

cerrarCuenta :: Evento
cerrarCuenta _ = 0

tocoYMeVoy :: Evento
tocoYMeVoy = (cerrarCuenta . upgrade . depositar 15)

ahorranteErrante :: Evento
ahorranteErrante = (depositar 10 . upgrade . depositar 8 . extraer 1 . depositar 2 . depositar 1) 

quedaIgual :: Evento
quedaIgual saldoBilletera = saldoBilletera

--------------------
-- TRANSACCIONES  --
--------------------

transaccionUno :: Operacion
transaccionUno    = transaccion "Luciano" cerrarCuenta

transaccionDos :: Operacion
transaccionDos    = transaccion "Jose" (depositar 5)

transaccionTres :: Operacion
transaccionTres   = transaccion "Luciano" tocoYMeVoy

transaccionCuatro :: Operacion
transaccionCuatro = transaccion "Luciano" ahorranteErrante

transaccionCinco :: Operacion
transaccionCinco  = transferencia "Jose" "Luciano" 7


------------------------------
-- TRANSACCIONES ESCALABLES --
------------------------------

validacion :: Nombre -> Usuario -> Bool
validacion nombreAComparar (Usuario nombre _ ) = nombreAComparar == nombre

transaccion :: Nombre -> Evento -> Operacion
transaccion nombreAComparar eventoAAplicar usuario | validacion nombreAComparar usuario = eventoAAplicar
                                                   | otherwise                          = quedaIgual

transferencia :: Nombre -> Nombre -> Dinero -> Operacion
transferencia nombreEmisor nombreDestinatario montoAPagar usuario | montoAPagar < 0                       = error "No se puede depositar un monto negativo"
                                                                  | validacion nombreEmisor usuario       = transaccion nombreEmisor (extraer montoAPagar) usuario
                                                                  | validacion nombreDestinatario usuario = transaccion nombreDestinatario (depositar montoAPagar) usuario
                                                                  | otherwise                             = quedaIgual

--PARTE 2--

--------------
-- IMPACTAR --
--------------

-- Sacar usuario

bloqueUno:: Bloque
bloqueUno = [transaccionUno, transaccionDos, transaccionDos, transaccionDos, transaccionTres, transaccionCuatro, transaccionCinco, transaccionTres]

bloqueDos:: Bloque
bloqueDos = [transaccionDos, transaccionDos, transaccionDos, transaccionDos, transaccionDos]

blockChain:: BlockChain
blockChain = [bloqueDos, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno]


impactar transaccionAImpactar (Usuario nombre billetera ) = Usuario nombre (transaccionAImpactar (Usuario nombre billetera) billetera)

impactarBloque :: Bloque -> Usuario -> Usuario
impactarBloque [] usuario = usuario
impactarBloque (cabezaBloques:colaBloques) usuario = impactarBloque colaBloques (impactar cabezaBloques usuario)


quienesQuedanConAlMenos :: SaldoBilletera -> Bloque -> [Usuario] -> [Usuario]
quienesQuedanConAlMenos _ _ [] = []
quienesQuedanConAlMenos saldoMinimo bloqueAAplicar (cabezaUsuarios:colaUsuarios) | saldoBilletera (impactarBloque bloqueAAplicar cabezaUsuarios) > saldoMinimo = cabezaUsuarios : quienesQuedanConAlMenos saldoMinimo bloqueAAplicar colaUsuarios
                                                                                 | otherwise                                                                    = quienesQuedanConAlMenos saldoMinimo bloqueAAplicar colaUsuarios

elMasAdineradoLuegoDeBloque :: Bloque -> [Usuario] -> Usuario
elMasAdineradoLuegoDeBloque _ [unicoUsuarioEnLista] = unicoUsuarioEnLista
elMasAdineradoLuegoDeBloque bloqueAAplicar (primeroUsuarios:segundoUsuarios:colaUsuarios) | saldoBilletera (impactarBloque bloqueAAplicar primeroUsuarios) >= saldoBilletera (impactarBloque bloqueAAplicar segundoUsuarios) = elMasAdineradoLuegoDeBloque bloqueAAplicar (primeroUsuarios:colaUsuarios)
                                                                                          | otherwise                                                                                                                        = elMasAdineradoLuegoDeBloque bloqueAAplicar (segundoUsuarios:colaUsuarios)
elMenosAdineradoLuegoDeBloque :: Bloque -> [Usuario] -> Usuario
elMenosAdineradoLuegoDeBloque _ [unicoUsuarioEnLista] = unicoUsuarioEnLista
elMenosAdineradoLuegoDeBloque bloqueAAplicar (primeroUsuarios:segundoUsuarios:colaUsuarios) | saldoBilletera (impactarBloque bloqueAAplicar primeroUsuarios) <= saldoBilletera( impactarBloque bloqueAAplicar segundoUsuarios) = elMenosAdineradoLuegoDeBloque bloqueAAplicar (primeroUsuarios:colaUsuarios)
                                                                                            | otherwise                                                                                                                = elMenosAdineradoLuegoDeBloque bloqueAAplicar (segundoUsuarios:colaUsuarios)
peorBloqueDelBlockChain:: Usuario -> BlockChain -> Bloque 
peorBloqueDelBlockChain _ [unBloque] = unBloque
peorBloqueDelBlockChain unUsuario (primerBloque:segundoBloque:colaDeBloques) | saldoBilletera (impactarBloque primerBloque unUsuario) <= saldoBilletera (impactarBloque segundoBloque unUsuario) = peorBloqueDelBlockChain unUsuario (primerBloque:colaDeBloques)
                                                                             | otherwise                                                                                                         = peorBloqueDelBlockChain unUsuario (segundoBloque:colaDeBloques)

impactarBlockChain :: BlockChain -> Usuario -> Usuario
impactarBlockChain  [] usuario = usuario
impactarBlockChain  (primerBloque:colaDeBloques) usuario  = impactarBlockChain colaDeBloques (impactarBloque primerBloque usuario) 

saldoHastaN :: Int -> [Bloque] -> Usuario -> Usuario
saldoHastaN limite unBlockChain usuario  = impactarBlockChain (take limite unBlockChain) usuario

aplicacionDeBlockChainAUsuarios unBlockChain unaListaDeUsuarios  = map (impactarBlockChain unBlockChain) unaListaDeUsuarios



