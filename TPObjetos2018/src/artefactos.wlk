import rolando.*
import fuerzaOscura.*

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
	var property refuerzo = ninguno
		
	method unidadDeLucha()= self.refuerzo().unidadDeLucha() + 2

}

object cotaDeMalla {
	var property unidadDeLucha = 1
}

object bendicion {
	var property unidadDeLucha
	method unidadDeLucha()= rolando.nivelDeHechiceria()
}

object ninguno {
	var property unidadDeLucha = 0
}

object hechizo {
	var property hechizo
	var property unidadDeLucha
	
	method unidadDeLucha()=hechizo.poder()
}

object espejo{
	var property unidadDeLucha = 0
	method mejorPertenencia(){
		var pertenencias = []
		pertenencias.addAll(rolando.artefactos()) // Esto, como lo de arriba, me hace un poco de ruido, porque si yo cambio de persona, deberia cambiar esto, pero deberia estar generico tambien, ¿se entiende?
		pertenencias.remove(self)
		if (pertenencias!=[]){return pertenencias.max({artefacto => artefacto.unidadDeLucha()})
		}
		return ninguno
}

	method unidadDeLucha() = self.mejorPertenencia().unidadDeLucha()
}


