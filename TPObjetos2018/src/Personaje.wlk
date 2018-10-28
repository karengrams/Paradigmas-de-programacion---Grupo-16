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
	
	// SEGUNDA ENTREGA
		
 
 	method canjeaHechizo(hechizoNuevo){
 		self.lanzaExcepcionSi(self.noPodesCanjearHechizo(hechizoNuevo),'Ni tu hechizo preferido ni tus monedas de oro abarca las monedas necesarias para canjear el hechizo solicitado. Cumpli objetivos para aumentar las monedas de oro.')
 		self.monedasDeOro(self.monedasDeOro().min(self.monedasDeOro()+self.valorDeHechizoPreferido()-hechizoNuevo.valor()))
 	}
 	
 	method valorDeHechizoPreferido()=self.hechizoPreferido().valor()/2
 	
 	method podesCanjearHechizo(unHechizo)=self.monedasDeOro()+self.hechizoPreferido().valor()>=unHechizo.valor()
 	
 	method noPodesCanjearHechizo(unHechizo)=self.podesCanjearHechizo(unHechizo).negate()
 		
 	method compraArtefacto(artefactoNuevo){
 		self.lanzaExcepcionSi(self.noPodesComprarArtefacto(artefactoNuevo),'No te alcanzan las monedas de oro para adquirir el nuevo artefacto. Cumpli objetivos para aumentar tus monedas de oro.')
 		self.agregaArtefacto(artefactoNuevo)
 		self.monedasDeOro(self.monedasDeOro()-artefactoNuevo.valor())
 	}
 	
 	method podesComprarArtefacto(artefacto)=self.monedasDeOro()>=artefacto.valor()
 	
 	method noPodesComprarArtefacto(artefacto)=self.podesComprarArtefacto(artefacto).negate()
 	
	method cumpleObjetivo()=self.monedasDeOro(self.monedasDeOro()+10)
	
	method lanzaExcepcionSi(condicion, mensaje){
   		if(condicion){ throw new NoSePuedeComprarOCanjear(mensaje) }
   	}

}

class NoSePuedeComprarOCanjear inherits Exception{}
