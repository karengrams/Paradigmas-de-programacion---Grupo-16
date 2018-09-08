import hechizos.*
import artefactos.*
import fuerzaOscura.*

object rolando {
	
	var property baseDeHechiceria = 3
	var property nivelDeHechiceria = 0
	var property hechizoPreferido = espectroMalefico
	
	var property nivelDeLucha = 0
	var property baseDeLucha = 1
	const property artefactos = []
	
	/* PUNTO 1 */
	
	
	method nivelDeHechiceria()= (self.baseDeHechiceria()*hechizoPreferido.nivelDePoder()) + fuerzaOscuraGlobal.poder()
	
	method sosPoderoso()= self.hechizoPreferido().sosPoderoso()
	
	/* PUNTO 2 */
	
	method nivelDeLucha() = self.baseDeLucha() + self.dameTusPuntosDeLucha()
	
	method dameTusPuntosDeLucha () = 
		self.artefactos().sum({
			artefacto => artefacto.dameTusPuntosDeLucha(self.artefactos(), self.nivelDeHechiceria())
		})
	
	method agregaArtefacto(nuevoArtefacto) {
		self.artefactos().add(nuevoArtefacto)
	}

	method sacaArtefacto(nuevoArtefacto) {
		self.artefactos().remove(nuevoArtefacto)
	}
	
	method tenesMayorNivelDeLuchaQueNivelDeHechiceria() = self.nivelDeLucha()>self.nivelDeHechiceria()
	
	/* PUNTO 3 */
	
	method estasCargado() = self.artefactos().size() >= 5
	
}
