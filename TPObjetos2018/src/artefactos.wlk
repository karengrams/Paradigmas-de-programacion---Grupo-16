import Personaje.*
import fuerzaOscura.*
import hechizos.*

// ARTEFACTOS

class Artefacto{
	const property fechaDeCompra = new Date()
	method peso() = 0 /* Si se coloca una property aca, entonces, se podra "modificar" el peso de cualquier artefacto, 
	* sin embargo, el libro de hechizos no tiene peso, suena ilogico poder cambiarle el peso pero luego a la hora de
	* preguntarle el mismo, que siempre devuelva 0.  */
	method valor()
	method unidadDeLucha(unPersonaje)
	method pesoTotal()=self.peso()-self.factorDeCorrecion()
	method factorDeCorrecion() = ((new Date() - self.fechaDeCompra())/1000).min(1)
}

class Arma inherits Artefacto{
	var property unidadLucha=3
	var property pesoArma
	
	override method unidadDeLucha(unPersonaje)=self.unidadLucha()
	
	override method valor()=self.pesoArma()*5
	
	override method peso()=self.pesoArma()
	 
	//  No tienen peso adicional
}

object collarDivino inherits Artefacto{	
	var property perlas = 1
	
	override method unidadDeLucha(unPersonaje)= self.perlas()
	
	override method valor()=2*self.perlas()
	
	override method pesoTotal()= super()+self.perlas()*0.5
	
}

class Mascara inherits Artefacto{
	var property indiceDeOscuridad
	var property minimoDeMascara = 4
	var property pesoMascara
	
	override method unidadDeLucha(unPersonaje) = self.unidadDeLucha()
	
	method unidadDeLucha() = self.minimoDeUnidadDeLuchaSegunMascara(self.cantidadDeUnidadDeLucha())
		
	method cantidadDeUnidadDeLucha()=fuerzaOscura.poder()/2*self.indiceDeOscuridad()
	
	method minimoDeUnidadDeLuchaSegunMascara(valor)=valor.max(self.minimoDeMascara())
	
	override method valor()= 10 * self.indiceDeOscuridad()
		
	override method pesoTotal()=super()+self.pesoAdicionalMascara()
	
	override method peso()=self.pesoMascara()
	
	method pesoAdicionalMascara()=(self.unidadDeLucha()-3).max(0)
}

/* ¿Por que un objeto? Porque no tiene estado interno el cual guarde quien es su duenio, por ende, resulta innecesario la 
 * existencia de muchos espejos, con un solo objeto espejo, es suficiente.
 */

object espejo inherits Artefacto{
	var property pesoEspejo
	
	override method unidadDeLucha(unPersonaje){
		if(unPersonaje.artefactos().filter({artefacto => artefacto!=self}).isEmpty()) {return 0}
		else{
			return self.elMejorArtefacto(self.eliminarEspejo(unPersonaje.artefactos()),unPersonaje).unidadDeLucha(unPersonaje) 
		}
	}
	
	method eliminarEspejo(artefactos)=artefactos.filter({artefacto=>artefacto!=self})
	
	method elMejorArtefacto(unosArtefactos,unPersonaje)=unosArtefactos.max({artefacto=>artefacto.unidadDeLucha(unPersonaje)})
	
	override method valor()=90
	
	override method peso()=self.pesoEspejo()
	
	// No tienen peso adicional

}

class Armadura inherits Artefacto{
	var property refuerzo = ninguno
	var property valorBase = 2
	var property pesoArmadura
	
	override method valor()=refuerzo.valorDeRefuerzo(self)

	override method unidadDeLucha(unPersonaje)= self.refuerzo().unidadDeLucha(unPersonaje)+self.valorBase()
	
	override method pesoTotal()=super()+refuerzo.pesoDeRefuerzo()
	
	override method peso()=self.pesoArmadura()
	
}

// REFUERZOS

class Refuerzo{
	method unidadDeLucha(unPersonaje)
	method valorDeRefuerzo(unaArmadura)
	method pesoDeRefuerzo()=0
}

class CotaDeMalla inherits Refuerzo{
	var property unidadLucha
		
	override method unidadDeLucha(unJugador)=self.unidadLucha()

	override method valorDeRefuerzo(unaArmadura)=self.unidadLucha()/2
	
	override method pesoDeRefuerzo()=1
}
 
object bendicion inherits Refuerzo{
	override method valorDeRefuerzo(unaArmadura)=unaArmadura.valorBase()
	override method unidadDeLucha(unPersonaje) = unPersonaje.nivelDeHechiceria()
}

object ninguno inherits Refuerzo{
	override method valorDeRefuerzo(unValorBase)=2
	override method unidadDeLucha(unPersonaje)=0

}
