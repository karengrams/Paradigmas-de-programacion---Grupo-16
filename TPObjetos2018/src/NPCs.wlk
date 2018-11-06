import Personaje.*

class PersonajeNoControlado inherits Personaje {

	var property dificultad

	override method nivelDeLucha() = super() * self.dificultad().multiplicador()

}

object facil {

	var property multiplicador = 1

}

object moderada {

	var property multiplicador = 2

}

object dificil {

	var property multiplicador = 4

}

