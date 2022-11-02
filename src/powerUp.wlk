class PowerUp {

	method darPoder(jugador) {
	}

}

class VelocidadPower inherits PowerUp
{
	override method darPoder(jugador){
		jugador.velocidad(150)
	}
}

