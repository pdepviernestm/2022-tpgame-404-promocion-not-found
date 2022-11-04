import wollok.game.*
import config.*

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
		config.nivelActual().powerUps().remove(self)
		game.schedule(7000, {=> jugador.vaRapido(false)})
	}
	method quitarPoder(jugador){
		jugador.vaRapido(false)
	}
}

