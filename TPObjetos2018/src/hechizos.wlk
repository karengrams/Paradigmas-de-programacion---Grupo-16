import artefactos.*

class Logo{
	var property nombre=''
	var property multiplo = 1
		
	method valor()=self.poder()
	
	method poder()= self.nombre().size()*self.multiplo()
	
	method unidadDeLucha(unPersonaje)=self.poder()
	
	method sosPoderoso()= self.poder() > 15	

}

object hechizoBasico{
	var property valor = 10
	var property poder = 10	

	method sosPoderoso()= false
	
	
	method unidadDeLucha(unPersonaje)=self.poder()
	
}

/* A diferencia del espejo, un libro de hechizos si necesita ser una clase, ¿por que? Porque el libro tiene estado interno,
 * el cual, dependiendo de los hechizos que se tenga, dara cierta cantidad de nivel de hechiceria al personaje.
 */
 
/* Si el libro de hechizos se tiene a si mismo, se produciria un loop infinito, por ende, hay que sacarlo como se hizo con el 
 * espejo.
 */

class LibroDeHechizos inherits Artefacto{ // ARTEFACTO
	const property listaDeHechizos = []
	
	method nuevosHechizos(nuevosHechizos){
		listaDeHechizos.clear()
		listaDeHechizos.addAll(nuevosHechizos.filter({artefacto=>artefacto!=self}))
	}
		
	method listaDeHechizosPoderosos() = listaDeHechizos.filter({hechizo => hechizo.sosPoderoso()})
	
	method poder() = self.listaDeHechizosPoderosos().sum({hechizo => hechizo.poder()}) // Esto usa el personaje para saber su poder
	
	override method valor()=self.listaDeHechizos().size()*10+self.poder()
	
	override method unidadDeLucha(unPersonaje)=0 /* En los test chilla de que no se puede instanciar una esta clase porque 
	 * al heredar de artefacto, si o si necesita unidadDeLucha()
	 */
	
}

