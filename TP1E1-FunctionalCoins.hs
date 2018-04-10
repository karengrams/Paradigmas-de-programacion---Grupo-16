-- Functional Coins - Entrega 1
-- Grupo 16

{-# LANGUAGE NoMonomorphismRestriction #-}

import Text.Show.Functions -- Para mostrar <Function> en consola cada vez que devuelven una.
import Data.List -- Para m�todos de colecciones que no vienen por defecto.
import Data.Maybe -- Por si llegan a usar un m�todo de colecci�n que devuelva �Just suElemento� o �Nothing�.
{-import Test.Hspec -- Para poder usar los tests que se piden m�s abajo.-}

data Billetera = Billetera {
nombre :: String,
dinero :: Float
} deriving (Show, Eq)

type Evento = Billetera -> Billetera

sinDinero billetera = billetera { dinero = 0 }

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

unaBilletera = Billetera "Facundo" 1023
billeteraPepe = Billetera "Jose" 10
billeteraPepe2 = Billetera "Jose" 20
billeteraPepe3 = Billetera "Jose" 50
billeteraLucho = Billetera "Luciano" 10

transaccionUno :: Evento
transaccionUno billetera | nombre billetera == "Luciano" =  cerrarCuenta billetera
                         | otherwise = quedaIgual billetera

transaccionDos :: Evento
transaccionDos billetera | nombre billetera == "Jose" =  depositar 5 billetera
                         | otherwise = quedaIgual billetera


type Transaccion = String -> Evento -> Evento

transaccion :: Transaccion
transaccion nombreAComparar eventoAAplicar billeteraAfectada | nombre billeteraAfectada == nombreAComparar = eventoAAplicar billeteraAfectada
                                                                    | otherwise = quedaIgual billeteraAfectada

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

transaccionCinco billetera | nombre billetera == "Jose"    = extraer (-7) billetera
                           | nombre billetera == "Luciano" = depositar (7) billetera
                           | otherwise                     = quedaIgual billetera
