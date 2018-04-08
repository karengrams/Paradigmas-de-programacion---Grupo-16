-- Functional Coins - Entrega 1
-- Grupo 16

{-# LANGUAGE NoMonomorphismRestriction #-}

import Text.Show.Functions -- Para mostrar <Function> en consola cada vez que devuelven una.
import Data.List -- Para métodos de colecciones que no vienen por defecto.
import Data.Maybe -- Por si llegan a usar un método de colección que devuelva “Just suElemento” o “Nothing”.
import Test.Hspec -- Para poder usar los tests que se piden más abajo.

data Billetera = Billetera {nombre :: String, dinero :: Float} deriving (Show, Eq)

type Evento = Billetera -> Billetera

depositar :: Float -> Evento
depositar dineroDepositado billetera = billetera {dinero = (dinero billetera + dineroDepositado)} 

extraer :: Float -> Evento
extraer dineroExtraido billetera = billetera {dinero = (max) 0 (dinero billetera + dineroExtraido)}
-- Por el enunciado entiendo que en una extraccion el monto se ingresa negativo, por eso lo sumo al monto original.

upgrade :: Evento
upgrade billetera = billetera {dinero = (dinero billetera + (min) 10 (0.20 * dinero billetera))}

cerrarCuenta :: Evento
cerrarCuenta billetera = billetera {dinero = 0}

quedaIgual ::Evento
quedaIgual billetera = billetera

