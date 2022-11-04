import wollok.game.*

class PowerUp {
	var property position

	method darPoder(jugador) {
		game.removeVisual(self)
	}

}

class VelocidadPower inherits PowerUp
{
	
	method image() = "powerUp_velocidad.png"
	
	override method darPoder(jugador){
		jugador.vaRapido(true)
		super(jugador)
		game.schedule(7000, {=> jugador.vaRapido(false)})
	}
	
}

