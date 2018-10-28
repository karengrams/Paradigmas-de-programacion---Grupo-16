import Personaje.*
import fuerzaOscura.*
import hechizos.*

// ARTEFACTOS

class Artefacto{
	method valor()
	method unidadDeLucha(unPersonaje)
}

class Arma inherits Artefacto{
	override method unidadDeLucha(unPersonaje)=3
	override method valor()=self.unidadDeLucha(self)*5 // Me pide si o si un parametro mas, cuando llamdo a unidadDeLucha(), 
	// por ende le puse 'self', pero me hace mas ruido que el tren San Martin,¿alguna forma de solucionarlo?
}

object collarDivino{
	var property perlas = 1
	method unidadDeLucha(unPersonaje)= self.perlas()
	method valor()=2*self.perlas()
}

class Mascara inherits Artefacto{
	var property indiceDeOscuridad

	var property minimoDeMascara
	
	override method unidadDeLucha(unPersonaje) = self.minimoDeUnidadDeLuchaSegunMascara(self.cantidadDeUnidadDeLucha())
		
	method cantidadDeUnidadDeLucha()=fuerzaOscura.poder()/2*self.indiceDeOscuridad()
	
	method minimoDeUnidadDeLuchaSegunMascara(valor)=valor.max(self.minimoDeMascara())
	
	override method valor()=0
}

/* ¿Por que un objeto? Porque no tiene estado interno el cual guarde quien es su duenio, por ende, resulta innecesario la 
 * existencia de muchos espejos, con un solo objeto espejo, es suficiente.
 */

object espejo inherits Artefacto{

	override method unidadDeLucha(unPersonaje){
		if(unPersonaje.artefactos().filter({artefacto => artefacto!=self}).isEmpty()) {return 0}
		else{
			return self.elMejorArtefacto(self.eliminarEspejo(unPersonaje.artefactos()),unPersonaje).unidadDeLucha(unPersonaje) 
		}
	}
	
	override method valor()=90
	
	method eliminarEspejo(artefactos)=artefactos.filter({artefacto=>artefacto!=self})
	
	method elMejorArtefacto(unosArtefactos,unPersonaje)=unosArtefactos.max({artefacto=>artefacto.unidadDeLucha(unPersonaje)})
	
}

class Armadura inherits Artefacto{
	var property refuerzo = ninguno
	var property valorBase = 2
	
	override method valor()=refuerzo.valor(self)

	override method unidadDeLucha(unPersonaje)= self.refuerzo().unidadDeLucha(unPersonaje)+self.valorBase()

}

// REFUERZOS

class Refuerzo{
	method unidadDeLucha(unPersonaje)
	method valor(unaArmadura)
}

class CotaDeMalla inherits Refuerzo{
	var property unidadLucha
	
	override method unidadDeLucha(unJugador)=self.unidadLucha()

	override method valor(unaArmadura)=self.unidadLucha()/2
}
 
object bendicion inherits Refuerzo{
	override method valor(unaArmadura)=unaArmadura.valorBase()
	override method unidadDeLucha(unPersonaje) = unPersonaje.nivelDeHechiceria()
}

object ninguno inherits Refuerzo{
	override method valor(unValorBase)=2
	override method unidadDeLucha(unPersonaje)=0

}
