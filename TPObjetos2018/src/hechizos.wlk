import artefactos.*

class Hechizo {
	
	method descuento(personaje)=personaje.hechizoPreferido().valor()/2

	method poder()

	method valor() = self.poder()

	method unidadDeLucha(unPersonaje) = self.poder()

	method sosPoderoso() = self.poder() > 15

	// REFUERZO (p/ armadura)
	method peso() = 0 // No tienen peso

	method valorDeRefuerzo(unaArmadura) = self.valor() + unaArmadura.valorBase()

	method pesoDeRefuerzo() {
		if (self.poder().even()) {
			return 2
		} else {
			return 1
		}
	}
	
	method teCompra(personaje){
		personaje.hechizoPreferido(self)
	}

}

object hechizoComercial inherits Hechizo {

	const property nombre = 'El hechizo comercial'
	var property multiplo = 2
	var property porcentaje = 0.2

	override method poder() = self.nombre().size() * self.multiplo() * self.porcentaje()

}

class Logo inherits Hechizo {

	var property nombre = ''
	var property multiplo = 1

	override method poder() = self.nombre().size() * self.multiplo()

}

object hechizoBasico inherits Hechizo {

	override method poder() = 10

}

