# Paradigmas de programacion (Grupo 16)
# Functional Coins - Entrega 1
Las BlockChains son cada vez más populares para almacenar datos distribuidos a lo largo del mundo. Así que venimos a reinventar la rueda y hacer nuestro propio BlockChain para guardar transacciones de nuestra moneda funcional.

# Eventos
Hay distintos eventos que pueden acontecer sobre la billetera (una cantidad de dinero) de un usuario. Por ejemplo:
* Depósito. El resultado final, será el dinero depositado + el dinero original de la billetera.
* Extracción. En vez de poner ese dinero, pone ese monto pero negativo. El dinero sale de la cuenta, para depositarse en otra o para canjearlo por dinero real. Si el resultado final es negativo, se debe dejar en 0.
* Upgrade. Se da cuando pasa de nivel. Se lo premia aumentando la billetera un 20%, pero ese aumento tiene un tope de 10 unidades.
* Cierre de cuenta. Vende todo su dinero así que la billetera queda en cero.
* Queda igual. Este evento no modifica la billetera.
* Definir y utilizar el tipo Evento para cada caso.
* Consultar lo siguiente, verificando que cada resultado es correcto: Cómo queda una billetera de 10 monedas, luego de…

# Tips
Antes de arrancar, recuerden agregar estas líneas al principio de su archivo:
    {-# LANGUAGE NoMonomorphismRestriction #-}
    import Text.Show.Functions -- Para mostrar <Function> en consola cada vez que devuelven una
    import Data.List -- Para métodos de colecciones que no vienen por defecto (ver guía de lenguajes)
    import Data.Maybe -- Por si llegan a usar un método de colección que devuelva “Just suElemento” o “Nothing”.
    import Test.Hspec -- Para poder usar los tests que se piden más abajo (ponerlo luego de instalar hspec!!)

Si requieren comparar un tipo compuesto definido por ustedes, recuerden poner al final *“deriving (Show, Eq)”*.

Definir y utilizar el tipo Evento para cada caso.
Consultar lo siguiente, verificando que cada resultado es correcto: Cómo queda una billetera de 10 monedas, luego de…

1) Depositar 10 más. Debería quedar con 20 monedas.
2) Extraer 3: Debería quedar con 7.
3) Extraer 15: Debería quedar con 0.
4) Un upgrade: Debería quedar con 12.
5) Cerrar la cuenta: 0.
6) Queda igual: 10.
7) Depositar 1000, y luego tener un upgrade: 1020.

