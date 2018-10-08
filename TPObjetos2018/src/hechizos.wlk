import artefactos.*

class Logo{
	var property nombre=''
	var property multiplo = 1
		
	method valor()=self.poder()
	
	method poder()= self.nombre().size()*self.multiplo()
	
	method unidadDeLucha()=self.poder()
	
	method sosPoderoso()= self.poder() > 15	

}

object hechizoBasico{
	var property valor = 10
	var property poder = 10	
	const property sosPoderoso = false
	
	method unidadDeLucha()=self.poder()
	
}

class LibroDeHechizos inherits Artefacto{ // ARTEFACTO
	const property listaDeHechizos = []
	
	method nuevosHechizos(nuevosHechizos){
		listaDeHechizos.clear()
		listaDeHechizos.addAll(nuevosHechizos.filter({artefacto=>artefacto!=self}))
	}
		
	method listaDeHechizosPoderosos() = listaDeHechizos.filter({hechizo => hechizo.sosPoderoso()})
	
	method poder() = self.listaDeHechizosPoderosos().sum({hechizo => hechizo.poder()})
	
	method valor()=self.listaDeHechizos().size()*10+self.poder()
	
}

