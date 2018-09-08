import hechizos.*
import artefactos.*
import fuerzaOscura.*

object espadaDelDestino {
	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = 3
}

object collarDivino {
	var property cantidadDePerlas = 1
	
	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = self.cantidadDePerlas()
}

object mascaraOscura {
	
	method puntosFuerzaOscura() = fuerzaOscuraGlobal.poder()/2
	
	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = self.puntosFuerzaOscura().max(4)
}

object espejo {
	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) {

		var listaSinEspejo = []
		listaSinEspejo.addAll(listaDeArtefactos)
		listaSinEspejo.remove(self)
		return listaSinEspejo.max({
			artefacto => artefacto.dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria)
		}).dameTusPuntosDeLucha(listaDeArtefactos,nivelDeHechiceria)
	}
}


object armadura {
	var property refuerzo = []

	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = 2 + self.refuerzo().dameTusPuntosDeLucha(nivelDeHechiceria)
}

/* Refuerzos */
/* Ibamos a hacer un nuevo archivo pero para un par de lineas nos parecio al pedo */

object cotaDeMalla {
	method dameTusPuntosDeLucha(nivelDeHechiceria) = 1
}

object bendicion {
	method dameTusPuntosDeLucha(nivelDeHechiceria) = nivelDeHechiceria
}

object ninguno {
	method dameTusPuntosDeLucha(nivelDeHechiceria) = 0
}

object libroDeHechizos {
	const listaDeHechizos = []
	
	method listaDeHechizosPoderosos() = listaDeHechizos.filter({hechizo => hechizo.sosPoderoso()})
	
	method nivelDePoder() = self.listaDeHechizosPoderosos().sum({hechizo => hechizo.nivelDePoder()})
}
