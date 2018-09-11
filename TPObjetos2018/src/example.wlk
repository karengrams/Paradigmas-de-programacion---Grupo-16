object fuerzaOscura{
	var property poder = 5
	
	method ocurreUnEclipse() = self.poder(self.poder()*2)
}

object rolando{
	var property baseDeHechiceria = 3
	var property nivelDeHechiceria = 0
	var property hechizoPreferido
	
	var property nivelDeLucha = 0
	var property baseDeLucha = 1
	const property artefactos = []
	
	/* PUNTO 1 */
	method nivelDeHechiceria()= self.baseDeHechiceria() * hechizoPreferido.poder() + fuerzaOscura.poder()
	method sosPoderoso()= self.hechizoPreferido().sosPoderoso()
	
	/* PUNTO 2 */
	
	method nivelDeLucha() = self.baseDeLucha() + self.unidadesDeLucha()
	
	method unidadesDeLucha()=
		self.artefactos().sum({
			artefacto => artefacto.unidadDeLucha()
		})	
	
	method agregaArtefacto(nuevoArtefacto) {
		self.artefactos().add(nuevoArtefacto)
	}

	method sacaArtefacto(unArtefacto) {
		self.artefactos().remove(unArtefacto)
	}
	
	method nuevosArtefactos(nuevosArtefactos){
		artefactos.clear()
		artefactos.addAll(nuevosArtefactos)
	}	
	
	/* PUNTO 3 */
	
	method estasCargado() = self.artefactos().size() >= 5
	

}

object espectroMalefico{
	var property nombre = 'Espectro Malefico'
	
	method poder()= self.nombre().length()
	
	method sosPoderoso()= self.poder() > 15	

}

object hechizoBasico{
	var property poder = 10
	const property sosPoderoso = false
}

object espadaDelDestino {
	const property unidadDeLucha = 3
}

object collarDivino {

	var property unidadDeLucha = 1
	
	method unidadDeLucha(perlas){
		unidadDeLucha=perlas
	}
}

object mascaraOscura {
	var property unidadDeLucha = 0
	
	method unidadDeLucha() = (fuerzaOscura.poder()/2).max(4)
	
}

object armadura {
	var property refuerzo
		
	method unidadDeLucha()= self.refuerzo().unidadDeLucha() + 2

}

object cotaDeMalla {
	var property unidadDeLucha = 1
}

object bendicion {
	var property unidadDeLucha
	/* wtf */
	/* Bendición: suma tantas unidades de lucha como nivel de hechicería obtenga quien posee la armadura. */
}

object ninguno {
	var property unidadDeLucha = 0
}

object hechizo {
	var property hechizo
	var property unidadDeLucha
	
	method unidadDeLucha()=hechizo.poder()
}

object libroDeHechizos {
	const listaDeHechizos = []
	
	method listaDeHechizosPoderosos() = listaDeHechizos.filter({hechizo => hechizo.sosPoderoso()})
	
	method nivelDePoder() = self.listaDeHechizosPoderosos().sum({hechizo => hechizo.nivelDePoder()})
}

object espejo {
	var property unidadDeLucha = 0
	method mejorPertenencia(){
		var pertenencias = []
		pertenencias.addAll(rolando.artefactos())
		pertenencias.remove(self)
		if (pertenencias!=[]){return pertenencias.max({artefacto => artefacto.unidadDeLucha()})
		}
		return ninguno
}

	method unidadDeLucha() = self.mejorPertenencia().unidadDeLucha()
}
