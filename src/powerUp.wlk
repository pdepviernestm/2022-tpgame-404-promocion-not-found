import wollok.game.*
import config.*

class PowerUp {
	var property position

	method serAgarrado(unJugador) {
		
		game.sound("sonidos/agarrar_powerUp.mp3").play()
		unJugador.reiniciarPowerUp()
		game.removeVisual(self)
	}

}

class VelocidadPower inherits PowerUp
{
	
	method image() = "powerUp_velocidad.png"
	
	override method serAgarrado(unJugador){
		super(unJugador)
		unJugador.powerUpActual(self)
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

