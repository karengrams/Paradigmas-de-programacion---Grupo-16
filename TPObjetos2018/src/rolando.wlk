import fuerzaOscura.*
import hechizos.*
import artefactos.*

object rolando{
	var property baseDeHechiceria = 3
	var property nivelDeHechiceria = 0
	var property hechizoPreferido = espectroMalefico
	
	var property nivelDeLucha = 0
	var property baseDeLucha = 1
	const property artefactos = []
	
	/* PUNTO 1 */
	method nivelDeHechiceria()= self.baseDeHechiceria() * hechizoPreferido.poder() + fuerzaOscura.poder()
	method sosPoderoso()= self.hechizoPreferido().sosPoderoso()
	
	/* PUNTO 2 */
	
	method nivelDeLucha() = self.baseDeLucha() + self.unidadesDeLucha()
	
	method unidadesDeLucha()=
		self.artefactos().sum({
			artefacto => artefacto.unidadDeLucha()
		})	
	
	method agregaArtefacto(nuevoArtefacto) {
		self.artefactos().add(nuevoArtefacto)
	}

	method sacaArtefacto(unArtefacto) {
		self.artefactos().remove(unArtefacto)
	}
	
	method nuevosArtefactos(nuevosArtefactos){
		artefactos.clear()
		artefactos.addAll(nuevosArtefactos)
	}	

	
	/* PUNTO 3 */
	
	method estasCargado() = self.artefactos().size() >= 5
	

}
