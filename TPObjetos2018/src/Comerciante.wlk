import Personaje.*
import artefactos.*
import hechizos.*

class Comerciante {
	const property itemsDisponibles = []
	var property impuesto
	
	
	method recategorizateCompulsivamente() = self.impuesto().recategorizaA(self)
		
	method cuantoVale(unItem) = unItem.valor() + self.impuesto().valorAdicional(unItem)
	
	method tenes(unItem) = self.itemsDisponibles().contains(unItem)
	
	method vendiste(unItem) = self.itemsDisponibles().remove(unItem)	
	
	method agregaEnStock(unItem) = self.itemsDisponibles().add(unItem)
}

class ImpuestoIndependiente {
	var property comision
	
	method valorAdicional (unItem) = unItem.valor() * self.comision()
	
	method recategorizaA (unComerciante) = self.comision(self.comision() * 2)
}

object impuestoRegistrado {
	const property iva = 0.21
	
	method valorAdicional (unItem) = unItem.valor() * self.iva()

	method recategorizaA (unComerciante){
		const nuevoImpuesto = new ImpuestoGanancias()
		unComerciante.impuesto(nuevoImpuesto)
	}
}

class ImpuestoGanancias {
	const property minimoNoImponible=5 //en el enunciado no se especifica el minimo no imponible para la recategorizacion
	const property porcentaje = 0.35
	
	method valorAdicional (unItem) {
		if (self.minimoNoImponible() < unItem.valor()){
			return (unItem.valor() - self.minimoNoImponible()) * porcentaje
		}
		
		return 0
	}
	
	method recategorizaA (unComerciante){}
}