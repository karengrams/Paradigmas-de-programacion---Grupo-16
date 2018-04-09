-- Functional Coins - Entrega 1
-- Grupo 16

{-# LANGUAGE NoMonomorphismRestriction #-}

import Text.Show.Functions -- Para mostrar <Function> en consola cada vez que devuelven una.
import Data.List -- Para métodos de colecciones que no vienen por defecto.
import Data.Maybe -- Por si llegan a usar un método de colección que devuelva “Just suElemento” o “Nothing”.
{-import Test.Hspec -- Para poder usar los tests que se piden más abajo.-}

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

--Aca lo unico que cambie es lo del 0, lo de "billetera {dinero = (max) 0 (dinero billetera + dineroExtraido)", no lo intente, pero me gustaria ver si funciona, queda muchisimo mejor y más corto, que la forma que yo puse

{-
extraer :: Float -> Evento
extraer dineroExtraido billetera = billetera {dinero = (max) 0 (dinero billetera + dineroExtraido)}
-- Por el enunciado entiendo que en una extraccion el monto se ingresa negativo, por eso lo sumo al monto original. 
-}


upgrade :: Evento
upgrade billetera 
  | (dinero billetera) * 0.2 <= 10 = billetera { dinero = (dinero billetera * 1.2) }
  | otherwise = billetera { dinero = (dinero billetera + 10)}
  
--Estuve viendo en el grupo que hay en la pagina del curso y preguntaron por esto, supuestamente se la agrega 10 si se supera, sino, se le agrega el 20%. Sigo con mis dudas igual, el martes le preguntamos a Santi.

  {-
  upgrade billetera = billetera {dinero = (dinero billetera + (min) 10 (0.20 * dinero billetera))}
  -}
 
cerrarCuenta :: Evento
cerrarCuenta billetera = sinDinero billetera

quedaIgual ::Evento
quedaIgual billetera = billetera

unaBilletera = Billetera "Facundo" 1023
billeteraPepe = Billetera "Jose" 10
billeteraLucho = Billetera "Luciano" 2