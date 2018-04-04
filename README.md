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
