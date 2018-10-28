import fuerzaOscura.*
import hechizos.*
import artefactos.*

class Personaje{
	var property nivelDeHechiceria = 0
	var property hechizoPreferido
	var property monedasDeOro=100
	
	var property nivelDeLucha = 0
	var property baseDeLucha = 1
	const property artefactos = []
	
	method baseDeHechiceria()=3
		
	method nivelDeHechiceria()= self.baseDeHechiceria() * hechizoPreferido.poder() + fuerzaOscura.poder()
	method sosPoderoso()= self.hechizoPreferido().sosPoderoso()
		
	method nivelDeLucha() = self.baseDeLucha() + self.unidadesDeLucha()
	
	method unidadesDeLucha()=
		self.artefactos().sum({
			artefacto => artefacto.unidadDeLucha(self)
		})		
	
	method agregaArtefacto(nuevoArtefacto){
		self.artefactos().add(nuevoArtefacto)
	}

	method sacaArtefacto(unArtefacto) {
		self.artefactos().remove(unArtefacto)
	}
	
	method nuevosArtefactos(nuevosArtefactos){
		artefactos.clear()
		artefactos.addAll(nuevosArtefactos)
	}	
	
	method estasCargado() = self.artefactos().size() >= 5
	
	// Segunda entrega 
	
	method compraArtefacto(artefactoNuevo){
		if(self.podesComprarArtefacto(artefactoNuevo)){
				self.agregaArtefacto(artefactoNuevo)
				self.monedasDeOro(self.monedasDeOro()-artefactoNuevo.valor())
			}
	}
	
	method compraHechizo(hechizoNuevo){
		if(self.podesComprarHechizo(hechizoNuevo)){
			self.monedasDeOro(self.monedasDeOro()+hechizoPreferido.valor()/2-hechizoNuevo.valor())
			self.hechizoPreferido(hechizoNuevo)	
		}
	}
	
	method podesComprarHechizo(hechizo)=self.monedasDeOro()+self.hechizoPreferido().valor()-hechizo.valor()>=0
	
	method podesComprarArtefacto(artefacto)=self.monedasDeOro()-artefacto.valor()>=0
	
	method canjeaHechizo(hechizo){
		if(hechizoPreferido.valor()/2>hechizo.valor()) { self.hechizoPreferido(hechizo) }
		else{self.compraHechizo(hechizo)}
	}

	method cumpleObjetivo()=self.monedasDeOro(self.monedasDeOro()+10)
	
}
