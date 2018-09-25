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

object espejo{
	method mejorPertenencia(){
		var pertenencias = []
		pertenencias.addAll(rolando.artefactos())
		pertenencias.remove(self)
		if (pertenencias.isEmpty().negate()){return pertenencias.max({artefacto => artefacto.unidadDeLucha()})
		}
		return ninguno
}

	method unidadDeLucha() = self.mejorPertenencia().unidadDeLucha()
}


