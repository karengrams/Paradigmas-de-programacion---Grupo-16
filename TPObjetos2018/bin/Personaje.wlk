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

	method compraA(unComerciante,objetoAComprar){
		self.lanzaExcepcionSi(self.noLePodesComprar(unComerciante,objetoAComprar),'No te alcanzan las monedas de oro para adquirir el nuevo artefacto. Cumpli objetivos para aumentar tus monedas de oro.')
		self.lanzaExcepcionSi(self.noPodesComprar(objetoAComprar), 'No te alcanzan las monedas de oro para adquirir el nuevo artefacto. Cumpli objetivos para aumentar tus monedas de oro.')
		self.monedasDeOro((self.monedasDeOro()-unComerciante.montoDelImpuestoAdicional(objetoAComprar)-self.objetoConDescuento(objetoAComprar)))
		objetoAComprar.teCompra(self)
	}
	
	method objetoConDescuento(objetoAComprar)=(objetoAComprar.valor()-objetoAComprar.descuento(self)).max(0)
	
	method noPodesComprar(objeto) = self.monedasDeOro() < objeto.valor()-objeto.descuento(self) 

	method superasTuCargaMaximaAgregando(artefactoNuevo) = artefactoNuevo.pesoTotal() + self.pesoTotalDeArtefactos() > self.limiteDeCarga()

	method cumpleObjetivo() = self.monedasDeOro(self.monedasDeOro() + 10)

	method pesoTotalDeArtefactos() = self.artefactos().sum({ artefacto => artefacto.pesoTotal() })
	
	method noLePodesComprar(vendedor,objetoAComprar)=objetoAComprar.valor()+vendedor.montoDelImpuestoAdicional(objetoAComprar) > self.monedasDeOro()+objetoAComprar.descuento(self)
	
	method lanzaExcepcionSi(condicion, mensaje) {
		if (condicion) {
			throw new NoSePuedeComprarOCanjear(mensaje)
		}
	}
	
	method artefactosSinEspejo() =self.artefactos().filter({artefacto=> artefacto!=espejo})
	 
	method mejorArtefacto()=self.artefactosSinEspejo().max({artefacto => artefacto.unidadDeLucha(self)})

}

class NoSePuedeComprarOCanjear inherits Exception {}

