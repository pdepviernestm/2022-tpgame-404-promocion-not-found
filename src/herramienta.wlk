import wollok.game.*
import config.*

class Herramienta {

	var property position
	method darHabilidad(jugador)
	{
		game.sound("sonidos/agarrar_herramienta.mp3").play()
		game.removeVisual(self)
	}
}

class Guante inherits Herramienta {

	method image() = "guante_magico.png"
	
	override method darHabilidad(jugador){
		super(jugador)
		jugador.herramientaActual(self)
		config.nivelActual().herramientas().remove(self)
	}
}

