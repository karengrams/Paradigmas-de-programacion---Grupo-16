import artefactos.*

class Hechizo{
	method poder()
	method valor()=self.poder()
	method unidadDeLucha(unPersonaje)=self.poder()
	method sosPoderoso()=self.poder()>15
	
	// REFUERZO (p/ armadura)
	
	method peso()=0 // No tienen peso
	method valorDeRefuerzo(unaArmadura)=self.valor()+unaArmadura.valorBase()
	method pesoDeRefuerzo(){
		if(self.poder().even()) { return 2 }
		else { return 1 }
	}
}

object hechizoComercial inherits Hechizo{
	const property nombre = 'El hechizo comercial'
	var property multiplo = 2
	var property porcentaje = 0.2
	override method poder()=self.nombre().size() * self.multiplo() * self.porcentaje()
}

class Logo inherits Hechizo{
	var property nombre=''
	var property multiplo = 1
		
	override method poder()= self.nombre().size()*self.multiplo()

}

object hechizoBasico inherits Hechizo{
	override method poder()=10	
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
	 
	// No tienen peso
}
