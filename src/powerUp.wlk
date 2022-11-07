import wollok.game.*
import config.*

class PowerUp {
	var property position

	method darPoder(jugador) {
		game.sound("sonidos/agarrar_powerUp.mp3").play()
		game.removeVisual(self)
	}

}

class VelocidadPower inherits PowerUp
{
	
	method image() = "powerUp_velocidad.png"
	
	override method darPoder(jugador){
		super(jugador)
		jugador.vaRapido(true)
		config.nivelActual().powerUps().remove(self)
		game.schedule(7000, {=> self.quitarPoder(jugador)})
	}
	method quitarPoder(jugador){
		jugador.vaRapido(false)
		jugador.powerUpActual(null)
	}
}

