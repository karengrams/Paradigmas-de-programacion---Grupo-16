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

Definir y utilizar el tipo Evento para cada caso. Consultar lo siguiente, verificando que cada resultado es correcto: Cómo queda una billetera de 10 monedas, luego de…
1) Depositar 10 más. Debería quedar con 20 monedas.
2) Extraer 3: Debería quedar con 7.
3) Extraer 15: Debería quedar con 0.
4) Un upgrade: Debería quedar con 12.
5) Cerrar la cuenta: 0.
6) Queda igual: 10.
7) Depositar 1000, y luego tener un upgrade: 1020.

# Usuarios
De los usuarios, sabemos su nombre y su billetera inicial. Asumimos que su nombre es único en todo el sistema.
A fines de hacer pruebas de nuestro código, crearemos a dos de los que podrían existir en el sistema:
* *Pepe*, que se llama "José" y arranca con 10 créditos en la billetera.
* *Lucho*, que se llama "Luciano" y arranca con 2 créditos en la billetera.

Consultar lo siguiente, sin definir nuevas funciones:
8) ¿Cuál es la billetera de Pepe? Debería ser 10 monedas.
9) ¿Cuál es la billetera de Pepe, luego de un cierre de su cuenta? Debería ser 0.
10) ¿Cómo quedaría la billetera de Pepe si le depositan 15 monedas, extrae 2, y tiene un Upgrade? Debería quedar en 27.6.

# Transacciones
Ahora tenemos Transacciones de cierto usuario por cierto evento. Por ejemplo: Pepe tiene un upgrade.
Ya no nos interesa el evento por separado, sino a quién debería aplicarse. ¿Por qué? Porque más adelante vamos a tener todas las transacciones mezcladas. Así que tenemos que poder aplicarlas a cualquier usuario, pero solo causar el evento deseado al que corresponda.
Por lo tanto, la transacción se puede aplicar a alguien, y eso produce cierto evento para su billetera.

Ejemplo: Con la transacción “Pepe tiene un upgrade”, si se aplica a Lucho, el resultado de esa transacción sería el evento “Queda igual”. Por el contrario, si se aplica a Pepe, el evento sería “Upgrade”(1) tal cual se definió en la transacción.
Al comparar si el usuario al cual se le aplica la transacción es el correcto, debemos fijarnos si tiene el mismo nombre.

Para facilitar las pruebas, crear las siguientes transacciones:
Transacción 1: Lucho cierra la cuenta.
Transacción 2: Pepe deposita 5 monedas.
La solución debe ser escalable para poder crear fácilmente transacciones sin repetir lógica, y que sea sencillo aplicarlas a distintos usuarios, teniendo en cuenta que el resultado deberá ser el evento de la transacción si es el usuario deseado o quedar igual si es cualquier otro.

Luego, consultar lo siguiente sin definir nuevas funciones:

11) Aplicar la transacción 1 a Pepe. Esto debería producir el evento “Queda igual”, que si se aplicara a una billetera de 20 monedas, deberá dar una billetera con ese mismo monto.
12) Hacer que la transacción 2 se aplique a Pepe. El resultado, deberá ser el evento de depositar 5 monedas. Aplicarlo a una billetera de 10 monedas, mostrando que queda con 15.
13) Crear un “Pepe 2” para hacer pruebas, que tenga todo igual al anterior, pero con saldo de 20.
Luego, hacer que la transacción 2 se aplique al nuevo Pepe. Aplicar el evento resultante a una billetera de 50 monedas, y verificar que aumenta quedando con 55.
Notar que si bien son 2 pepes diferentes (la transacción 2 se creó para el antiguo pero se aplicó en el nuevo), debemos saber que representan al mismo usuario por tener el mismo nombre.

Definir y utilizar el tipo Transacción de la forma más conveniente.

(1) Ayudita: Por más que lo pongamos entre comillas, no nos referimos a que se modele como un string, sino simplemente a citar la definición del evento de más arriba. Recuerden que es muy raro que queramos algo de tipo string.

# Nuevos eventos
Además de los anteriores, agregar:
* Toco y me voy: depósito de 15 monedas, tener un upgrade, y cierre de la cuenta.
* Ahorrante errante: depóstio de 1 moneda, luego depósito de 2, extracción de 1, depósito de 8, tener un upgrade, y depósito de 10.

Aclaración: A futuro, se cobrará una comisión por cada movimiento de dinero, así que queremos tener cada operación por separado. Es decir, en los casos como Ahorrante errante, debemos representar cada uno de los pasos sin juntarlos en uno solo (ejemplo, tener separado el depósito de 1 y luego el de 2, en vez de un solo depósito de 3).

Únicamente a fines de hacer pruebas, agregar estas dos transacciones:
* Transacción 3: Lucho toca y se va.
* Transacción 4: Lucho es un ahorrante errante.

14) y 15) Consultar cada caso al usuario que la generó, y ver cómo queda una billetera inicial de 10 monedas. En el primer caso quedaría con 0 (porque cerró su cuenta) y en el segundo 34.

# Pagos entre usuarios

Ahora tenemos transacciones más complejas, los pagos entre usuarios. Por ejemplo: Pepe le da 5 unidades a Lucho.
* Si la transacción se aplica a Pepe, el evento será de “extracción de 5 unidades”.
* Si la transacción se aplica a Lucho, el evento será de “depósito de 5 unidades”.
* En cualquier otro caso, la billetera queda igual (es decir, se produce el evento “Queda igual”)

Definir el tipo de estas situaciones de la manera más conveniente.
A fines de hacer pruebas, crear esta entidad, e indicar su tipo:
* Transacción 5: Pepe le da 7 unidades a Lucho.

La solución debe ser escalable para crear muchas transacciones de este estilo sin repetir lógica. Consultar:
16) Aplicar la transacción 5 a Pepe. Debería causar el evento de extracción de 7 unidades. Al aplicarlo a una billetera de 10 monedas, debería dar una nueva billetera de 3.
17) Aplicar la transacción 5 a Lucho. Debería causar el evento de depósito de 7 unidades. Al aplicarlo a una billetera de 10 monedas, quedando con 17.

# Testing
Se solicita modelar todas las consultas anteriores, como tests bien descriptivos.







