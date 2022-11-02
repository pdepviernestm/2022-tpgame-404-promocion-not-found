class PowerUp {
	var property position

	method darPoder(jugador) {
	}

}

class VelocidadPower inherits PowerUp
{
	
	method image() = "powerUp_velocidad.png"
	
	override method darPoder(jugador){
		jugador.velocidad(150)
	}
}

