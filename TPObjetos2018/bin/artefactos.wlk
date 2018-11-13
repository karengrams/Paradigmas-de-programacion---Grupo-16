import Personaje.*
import fuerzaOscura.*
import hechizos.*
import refuerzos.*

// ARTEFACTOS
class Artefacto {
	
	const property fechaDeCompra = new Date()

	method descuento(personaje)=0
	
	method peso() = 0

	method valor()

	method unidadDeLucha(unPersonaje)

	method pesoTotal() = self.peso() - self.factorDeCorrecion()

	method factorDeCorrecion() = ((new Date() - self.fechaDeCompra()) / 1000).min(1)

	method teCompra(personaje) {
		personaje.lanzaExcepcionSi(personaje.superasTuCargaMaximaAgregando(self), 'Superas la carga maxima establecida, ¡deshacete de algun artefacto!')
		personaje.agregaArtefacto(self)
	}

}

class Arma inherits Artefacto {

	var property unidadLucha = 3
	var property pesoArma = 0

	override method unidadDeLucha(unPersonaje) = self.unidadLucha()

	override method valor() = self.unidadLucha() * 5

	override method peso() = self.pesoArma()

}

object collarDivino inherits Artefacto {

	var property perlas = 1

	override method unidadDeLucha(unPersonaje) = self.perlas()

	override method valor() = 2 * self.perlas()

	override method pesoTotal() = super() + self.perlas() * 0.5

}

class Mascara inherits Artefacto {

	var property indiceDeOscuridad
	var property minimoDeMascara = 4
	var property pesoMascara

	override method unidadDeLucha(unPersonaje) = self.unidadLucha()

	method unidadLucha() = self.minimoDeUnidadDeLuchaSegunMascara(self.cantidadDeUnidadDeLucha())

	method cantidadDeUnidadDeLucha() = fuerzaOscura.poder() / 2 * self.indiceDeOscuridad()

	method minimoDeUnidadDeLuchaSegunMascara(valor) = valor.max(self.minimoDeMascara())

	override method valor() = 10*self.indiceDeOscuridad()

	override method pesoTotal() = super() + self.pesoAdicionalMascara()

	override method peso() = self.pesoMascara()

	method pesoAdicionalMascara() = (self.unidadLucha() - 3).max(0)

}

// ¿Por que un objeto? Porque no tiene estado interno el cual guarde quien es su duenio, por ende, resulta innecesario la existencia de muchos espejos, con un solo objeto espejo, es suficiente.
object espejo inherits Artefacto {

	var property pesoEspejo

	override method unidadDeLucha(personaje){
		if(personaje.artefactosSinEspejo().isEmpty()){
			return 0
		}
		else{
			return personaje.mejorArtefacto().unidadDeLucha(personaje)
		}
	} 

	method eliminarEspejo(artefactos) = artefactos.filter({ artefacto => artefacto != self })

	method elMejorArtefacto(unosArtefactos, unPersonaje) = unosArtefactos.max({ artefacto => artefacto.unidadDeLucha(unPersonaje) })

	override method valor() = 90

	override method peso() = self.pesoEspejo()

// No tienen peso adicional
}

class Armadura inherits Artefacto {

	var property refuerzo = ninguno
	var property valorBase = 2
	var property pesoArmadura = 0

	override method valor() = refuerzo.valorDeRefuerzo(self)

	override method unidadDeLucha(unPersonaje) = self.refuerzo().unidadDeLucha(unPersonaje) + self.valorBase()

	override method pesoTotal() = super() + refuerzo.pesoDeRefuerzo()

	override method peso() = self.pesoArmadura()

}

// A diferencia del espejo, un libro de hechizos si necesita ser una clase, ¿por que? Porque el libro tiene estado interno, el cual, dependiendo de los hechizos que se tenga, dara cierta cantidad de nivel de hechiceria al personaje.
// Si el libro de hechizos se tiene a si mismo, se produciria un loop infinito, por ende, hay que sacarlo como se hizo con el espejo.
class LibroDeHechizos inherits Hechizo {

	const property listaDeHechizos = []

	method nuevosHechizos(nuevosHechizos) {
		listaDeHechizos.clear()
		listaDeHechizos.addAll(nuevosHechizos.filter({ artefacto => artefacto != self}))
	}

	method listaDeHechizosPoderosos() = listaDeHechizos.filter({ hechizo => hechizo.sosPoderoso() })

	override method poder() = self.listaDeHechizosPoderosos().sum({ hechizo => hechizo.poder() }) // Esto usa el personaje para saber su poder

	override method valor() = self.listaDeHechizos().size() * 10 + self.poder()

}

