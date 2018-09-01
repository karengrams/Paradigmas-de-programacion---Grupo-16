/*ROLANDO */
object rolando {
	var baseDeHechiceria = 3
	var baseDeLucha = 1
	var hechizoPreferido = espectroMalefico
	const fuerzaOscura = fuerzaOscuraGlobal
	const artefactos = []
	
	method baseDeHechiceria() = baseDeHechiceria
	
	method cambiaTuBaseDeHechiceria(nuevaBase) {
		baseDeHechiceria = nuevaBase
	}
	
	method hechizoPreferido() = hechizoPreferido
	
	method cambiaTuHechizoPreferido(nuevoHechizo) {
		hechizoPreferido = nuevoHechizo
	}
	
	method fuerzaOscura () = fuerzaOscura
	
	method dameTuNivelDeHechiceria() = (self.baseDeHechiceria() * self.hechizoPreferido().dameTuPoder()) + self.fuerzaOscura().dameTuPoder()
	
	method sosPoderoso() = self.hechizoPreferido().sosPoderoso()
	
	method baseDeLucha() = baseDeLucha
	
	method cambiaTuBaseDeLucha(nuevaBase) {
		baseDeLucha = nuevaBase
	}
	
	method dameTuNivelDeLucha() = self.baseDeLucha() + self.puntosDeLuchaDeArtefactos()

	method artefactos() = artefactos
		
	method puntosDeLuchaDeArtefactos () = self.artefactos().sum({artefacto => artefacto.dameTusPuntosDeLucha(self.artefactos(), self.dameTuNivelDeHechiceria())})
	
	method agregaArtefacto(nuevoArtefacto) {
		self.artefactos().add(nuevoArtefacto)
	}

	method sacaArtefacto(nuevoArtefacto) {
		self.artefactos().remove(nuevoArtefacto)
	}
	
	method estasCargado() = self.artefactos().size() >= 5

}

/*HECHIZOS*/
object espectroMalefico {
	var nombre = "Espectro Malefico"
	
	method nombre() = nombre
	
	method cambiaDeNombre(nuevoNombre) {
		nombre = nuevoNombre
	}
	
	method dameTuPoder() = self.nombre().length()
	
	method sosPoderoso() = self.dameTuPoder() > 15
	
	method dameTusPuntosDeLucha() = self.dameTuPoder()
}

object hechizoBasico {
	method dameTuPoder() = 10
	
	method sosPoderoso() = false

	method dameTusPuntosDeLucha() = self.dameTuPoder()
}

object libroDeHechizos {
	const listaDeHechizos = []
	
	method listaDeHechizosPoderosos() = listaDeHechizos.filter({hechizo => hechizo.sosPoderoso()})
	
	method dameTuPoder() = self.listaDeHechizosPoderosos().sum({hechizo => hechizo.dameTuPoder()})
}


/*FUERZA OSCURA*/
object fuerzaOscuraGlobal {
	var valorBase = 5
	
	method dameTuPoder() = valorBase
	
	method ocurreUnEclipse() {
		valorBase = valorBase *2
	}
}

/*ARTEFACTOS*/
object espadaDelDestino {
	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = 3
}

object collarDivino {
	const cantidadDePerlas = 1
	
	method cantidadDePerlas() = cantidadDePerlas

	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = self.cantidadDePerlas()
}

object mascaraOscura {
	const fuerzaOscura = fuerzaOscuraGlobal
	
	method fuerzaOscura() = fuerzaOscura
	
	method puntosFuerzaOscura() = self.fuerzaOscura().dameTuPoder() /2
	
	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = self.puntosFuerzaOscura().max(4)
}

object espejo {
	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) {

	var listaSinEspejo = []
	listaSinEspejo.addAll(listaDeArtefactos)
	listaSinEspejo.remove(self)
	return listaSinEspejo.max({artefacto => artefacto.dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria)}).dameTusPuntosDeLucha(listaDeArtefactos,nivelDeHechiceria)
	
	}
}

object armadura {
	var refuerzo =  ninguno
	
	method dameTuRefuerzo() = refuerzo
	
	method cambiarRefuerzo(nuevoRefuerzo){
		refuerzo = nuevoRefuerzo
	}

	method dameTusPuntosDeLucha(listaDeArtefactos, nivelDeHechiceria) = 2 + self.dameTuRefuerzo().dameTusPuntosDeLucha(nivelDeHechiceria)
}

/*REFUERZOS*/
object cotaDeMalla {
	method dameTusPuntosDeLucha(nivelDeHechiceria) = 1
}

object bendicion {
	method dameTusPuntosDeLucha(nivelDeHechiceria) = nivelDeHechiceria
}

object ninguno {
	method dameTusPuntosDeLucha(nivelDeHechiceria) = 0
}



