object espectroMalefico {
	var property nombre = 'Espectro Malefico'
	
	method nivelDePoder()= self.nombre().length()
	
	method sosPoderoso()= self.nivelDePoder() > 15	

}

object hechizoBasico {
	var property nivelDePoder = 10
	var property sosPoderoso = false
}