class Comerciante {

	var property tipoDeImpuesto
	
	method montoDelImpuestoAdicional(objetoAVender) = self.tipoDeImpuesto().impuestoAdicionalDe(objetoAVender)

	method recategorizateCompulsivamente() = self.tipoDeImpuesto().recategorizaA(self)
	
}

class ImpuestoDeComercianteIndependiente {

	var property comision

	method impuestoAdicionalDe(objetoAVender) = objetoAVender.valor() * self.comision()

	method recategorizaA(unComerciante){
		if(self.comision() * 2 > 0.21){ unComerciante.tipoDeImpuesto(impuestoDeComercianteRegistrado)}
		else{ self.comision(self.comision()*2) }
	}

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

