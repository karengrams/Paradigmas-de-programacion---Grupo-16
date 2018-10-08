import Personaje.*
import fuerzaOscura.*
import hechizos.*

// ARTEFACTOS

class Artefacto{
	var property valor = 0
	var property unidadDeLucha = 0
}

class Arma inherits Artefacto{
	method unidadDeLucha()=3
	method valor()=self.unidadDeLucha()*5
}

object collarDivino{
	var property perlas = 1
	method unidadDeLucha()= self.perlas()
	method valor()=2*self.perlas()
}

class Mascara inherits Artefacto{
	var property indiceDeOscuridad = 0
	var property minimo = 1
	
	method unidadDeLucha() = (fuerzaOscura.poder()/2*self.indiceDeOscuridad()).max(self.minimo())
	
}

class Armadura inherits Artefacto{
	var property refuerzo = ninguno
	var property valorBase = 2
	
	method valor()=self.valorBase()+refuerzo.valor()

	method unidadDeLucha()= self.refuerzo().unidadDeLucha() + self.valorBase()

}

class Espejo inherits Artefacto{
	var property duenio	
	
	constructor(_duenio){
		duenio=_duenio
	}

	method unidadDeLucha(){
		if(duenio.artefactos().filter({artefacto => artefacto!=self}).isEmpty()) {return 0}
		else{
			return self.elMejorArtefacto(self.eliminarEspejo(duenio.artefactos())).unidadDeLucha() // Es una "composision"
		}
	}
	
	method eliminarEspejo(artefactos)=artefactos.filter({artefacto=>artefacto!=self})
	
	method elMejorArtefacto(unosArtefactos)=unosArtefactos.max({artefacto=>artefacto.unidadDeLucha()})
	
}

// REFUERZOS

class Refuerzo{
	var property unidadDeLucha = 0
	const property valor = 0
}

class CotaDeMalla inherits Refuerzo{
	method valor()=self.unidadDeLucha()/2
}

/* ¿Por que bendicion es una clase? Porque no es la misma bendicion que se le aplica a Rolando, que a la que se le aplicaria, 
 * por ejemplo, al personaje Marta. */
 
class Bendicion inherits Refuerzo{
	var bendecido
	constructor(unBendecido){
		bendecido=unBendecido
	}
	method valor()=0
	method unidadDeLucha()= bendecido.nivelDeHechiceria()
}

object ninguno{
	const property unidadDeLucha = 0
}
