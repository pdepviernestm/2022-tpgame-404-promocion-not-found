import wollok.game.*
import direcciones.*
import nivel.*
import config.*

class Item {

	var property position = game.center()

	var property image

	method puedeSerLlevado(jugador) {
		return !self.colisiona(jugador.direccionActual())
	}

	method serLlevado(jugador) {
		position = jugador.direccionAgarre().posSiguiente(jugador.position())
	}

	method colisiona(direccion){
		return config.nivelActual().colisionables().any{ colisionable => colisionable.position() == direccion.posSiguiente(position) }
	} 

	method estaEnElCamion(){
		return config.nivelActual().celdasCamion().any({ c => c.position() == position })
	}

}

class Borde {

	var property position

}

class Pared {

	var property position

}

class PisoCamion {

	var property position = game.center()
	
	//var property imagen
	
	//method image() = imagen

}

