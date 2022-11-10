import wollok.game.*
import config.*

class PowerUp {
	var property position
	
	method image() = "powerUp.png"

	method serAgarrado(unJugador) {
		
		unJugador.reiniciarPowerUp()
		game.removeVisual(self)
	}

}

class VelocidadPower inherits PowerUp
{	
	
	override method serAgarrado(unJugador){
		game.sound("sonidos/agarrar_powerUp.mp3").play()
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

class PowerMalo inherits PowerUp
{	
	
	override method serAgarrado(unJugador){
		game.sound("sonidos/congelado_inicio.mp3").play()
		super(unJugador)
		unJugador.powerUpActual(self)
		self.paralizar(unJugador)
		config.nivelActual().powerUps().remove(self)
		
		game.say(unJugador, "¡Estoy congelado!")
		game.onTick(4000, "darPoder" ,{=> unJugador.reiniciarPowerUp() game.sound("sonidos/congelado_fin.mp3").play() game.removeTickEvent("darPoder")})
	}
	method quitarPoder(unJugador){
		unJugador.estaInmovilizado(false)
		unJugador.powerUpActual(null)
	}
	
	method paralizar(unJugador){
		unJugador.estaInmovilizado(true)
	}
}

