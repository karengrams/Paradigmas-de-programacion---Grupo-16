class Comerciante {

	var property tipoDeImpuesto
	
	method montoDelImpuestoAdicional(objetoAVender) = self.tipoDeImpuesto().impuestoAdicionalDe(objetoAVender)

	method recategorizateCompulsivamente() = self.tipoDeImpuesto().recategorizaA(self)

	/*
	method tenes(unItem) = self.itemsDisponibles().contains(unItem)
	
	method vendiste(unItem) = self.itemsDisponibles().remove(unItem)	
	
	method agregaEnStock(unItem) = self.itemsDisponibles().add(unItem)
	 
	method noTenes(unItem) = self.tenes(unItem).negate()
	*/
	
}

class ImpuestoDeComercianteIndependiente {

	var property comision

	method impuestoAdicionalDe(objetoAVender) = objetoAVender.valor() * self.comision()

	method recategorizaA(unComerciante) = self.comision(self.comision() * 2)

}

object impuestoDeComercianteRegistrado {

	method impuestoAdicionalDe(objetoAVender) = objetoAVender.valor() * 0.21

	method recategorizaA(unComerciante) = unComerciante.tipoDeImpuesto(impuestoDeComercianteConImpuestoALaGanancia)

}

object impuestoDeComercianteConImpuestoALaGanancia {

	const property minimoNoImponible = 5
	const property porcentaje = 0.35

	method impuestoAdicionalDe(objetoAVender) {
		if (self.esMenorAlMinimoNoImponible(objetoAVender)) {
			return 0
		}
		return (objetoAVender.valor() - self.minimoNoImponible()) * self.porcentaje()
	}

	method esMenorAlMinimoNoImponible(objeto) = objeto.valor() < self.minimoNoImponible()

	method recategorizaA (unComerciante){}

}

