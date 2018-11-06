import Personaje.*
import fuerzaOscura.*
import hechizos.*
import refuerzos.*
import Comerciante.*
import artefactos.*

class Personaje {

	var property nivelDeHechiceria = 0
	var property hechizoPreferido
	var property monedasDeOro = 100
	var property nivelDeLucha = 0
	var property baseDeLucha = 1
	const property artefactos = []
	const property limiteDeCarga

	method baseDeHechiceria() = 3

	method nivelDeHechiceria() = self.baseDeHechiceria() * hechizoPreferido.poder() + fuerzaOscura.poder()

	method sosPoderoso() = self.hechizoPreferido().sosPoderoso()

	method nivelDeLucha() = self.baseDeLucha() + self.unidadesDeLucha()

	method unidadesDeLucha() = self.artefactos().sum({ artefacto => artefacto.unidadDeLucha(self) })

	method agregaArtefacto(nuevoArtefacto) {
		self.artefactos().add(nuevoArtefacto)
	}

	method sacaArtefacto(unArtefacto) {
		self.artefactos().remove(unArtefacto)
	}

	method nuevosArtefactos(nuevosArtefactos) {
		artefactos.clear()
		artefactos.addAll(nuevosArtefactos)
	}

	method estasCargado() = self.artefactos().size() >= 5

	// SEGUNDA ENTREGA
	method canjeaHechizo(hechizoNuevo) {
	}

	method valorDeHechizoPreferido() = self.hechizoPreferido().valor() / 2

	method compra(objetoAComprar) {
		self.lanzaExcepcionSi(self.noPodesComprar(objetoAComprar), 'No te alcanzan las monedas de oro para adquirir el nuevo artefacto. Cumpli objetivos para aumentar tus monedas de oro.')
		objetoAComprar.teCompra(self)
	}
	
	method compraA(unComerciante,objetoAComprar){
		// self.lanzaExcepcionSi(unComerciante.noTenes(objetoAComprar).negate(),'El comerciante no tiene el artefacto buscado en stock.')
		self.lanzaExcepcionSi(self.noLePodesComprar(unComerciante,objetoAComprar),'No te alcanzan las monedas de oro para adquirir el nuevo artefacto. Cumpli objetivos para aumentar tus monedas de oro.')
		self.compra(objetoAComprar)
		self.monedasDeOro(self.monedasDeOro()-unComerciante.montoDelImpuestoAdicional(objetoAComprar))
	}

	method poderComprar(objeto) = self.monedasDeOro() >= objeto.valor() || self.monedasDeOro() + self.hechizoPreferido().valor() >= objeto.valor()

	method noPodesComprar(objeto) = self.poderComprar(objeto).negate()

	method superasTuCargaMaximaAgregando(artefactoNuevo) = artefactoNuevo.pesoTotal() + self.pesoTotalDeArtefactos() > self.limiteDeCarga()

	method cumpleObjetivo() = self.monedasDeOro(self.monedasDeOro() + 10)

	method pesoTotalDeArtefactos() = self.artefactos().sum({ artefacto => artefacto.pesoTotal() })
	
	method lePodesComprarA(vendedor,objetoAComprar)=objetoAComprar.valor()+vendedor.montoDelImpuestoAdicional(objetoAComprar) < self.monedasDeOro()
	
	method noLePodesComprar(vendedor,objetoAComprar)=self.lePodesComprarA(vendedor,objetoAComprar).negate()

	method lanzaExcepcionSi(condicion, mensaje) {
		if (condicion) {
			throw new NoSePuedeComprarOCanjear(mensaje)
		}
	}

}

class NoSePuedeComprarOCanjear inherits Exception {}

