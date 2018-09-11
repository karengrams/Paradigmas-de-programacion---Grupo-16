import rolando.*
import fuerzaOscura.*

object espadaDelDestino {
	const property unidadDeLucha = 3
}

object collarDivino {

	var property perlas = 1
	
	method unidadDeLucha()= self.perlas()
	
}

object mascaraOscura {	
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
	method unidadDeLucha()= rolando.nivelDeHechiceria()
}

object ninguno {
	const property unidadDeLucha = 0
}

object hechizo {
	var property hechizo
		
	method unidadDeLucha()=hechizo.poder()
}

object espejo{
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


