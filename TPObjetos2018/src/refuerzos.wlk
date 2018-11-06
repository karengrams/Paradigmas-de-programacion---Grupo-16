import Personaje.*
import fuerzaOscura.*
import hechizos.*
import artefactos.*

// REFUERZOS
class Refuerzo {

	method unidadDeLucha(unPersonaje)

	method valorDeRefuerzo(unaArmadura)

	method pesoDeRefuerzo() = 0

}

class CotaDeMalla inherits Refuerzo {

	var property unidadLucha

	override method unidadDeLucha(unJugador) = self.unidadLucha()

	override method valorDeRefuerzo(unaArmadura) = self.unidadLucha() / 2

	override method pesoDeRefuerzo() = 1

}

object bendicion inherits Refuerzo {

	override method valorDeRefuerzo(unaArmadura) = unaArmadura.valorBase()

	override method unidadDeLucha(unPersonaje) = unPersonaje.nivelDeHechiceria()

}

object ninguno inherits Refuerzo {

	override method valorDeRefuerzo(unValorBase) = 2

	override method unidadDeLucha(unPersonaje) = 0

}

