
object espectroMalefico{
	var property nombre = 'Espectro Malefico'
	
	method poder()= self.nombre().length()
	
	method sosPoderoso()= self.poder() > 15	

}

object hechizoBasico{
	var property poder = 10
	const property sosPoderoso = false
}

object libroDeHechizos {
	const property listaDeHechizos = []
	
	method nuevosHechizos(nuevosHechizos){
		listaDeHechizos.clear()
		listaDeHechizos.addAll(nuevosHechizos)
	}
	
	method listaDeHechizosPoderosos() = listaDeHechizos.filter({hechizo => hechizo.sosPoderoso()})
	
	method poder() = self.listaDeHechizosPoderosos().sum({hechizo => hechizo.poder()})
}

