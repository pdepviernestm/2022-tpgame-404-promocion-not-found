import wollok.game.*
import config.*

class PowerUp {
	var property position

	method darPoder(unJugador) {
		game.sound("sonidos/agarrar_powerUp.mp3").play()
		game.removeVisual(self)
	}

}

class VelocidadPower inherits PowerUp
{
	
	method image() = "powerUp_velocidad.png"
	
	override method darPoder(unJugador){
		super(unJugador)
		unJugador.vaRapido(true)
		config.nivelActual().powerUps().remove(self)
		game.onTick(7000, "darPoder" ,{=> unJugador.reiniciarPowerUp()
			  							  game.removeTickEvent("darPoder")
		})
	}
	method quitarPoder(unJugador){
		unJugador.vaRapido(false)
		unJugador.powerUpActual(null)
	}
}

