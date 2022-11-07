import wollok.game.*
import direcciones.*
import nivel.*
import config.*

class Item {

	var property position = game.center()

	var property image
	
	var property estaSiendoCargado = false
	
	var property pesado

	method puedeSerLlevado(unJugador) {
		return !self.colisiona(unJugador.direccionActual(),unJugador) 
	}

	method serLlevado(unJugador) {
		position = unJugador.direccionAgarre().posSiguiente(unJugador.position())
	}

	method colisiona(direccion, unJugador){
	return game.getObjectsIn(direccion.posSiguiente(position)).any({ e => config.nivelActual().colisionables().contains(e)})
	       || config.jugadorContrario(unJugador).position() == direccion.posSiguiente(position)
	} 
	//return config.nivelActual().colisionables().any{ colisionable => colisionable.position() == direccion.posSiguiente(position) }

	method estaEnElCamion(){
		return config.nivelActual().celdasCamion().any({ c => c.position() == position })
	}

}

class Borde {

	var property position
    method image() = "numeros/sinImagen.png"
}

class Pared {

	var property position
    method image() = "numeros/sinImagen.png"
}

class PisoCamion {

	var property position = game.center()
	
	//var property imagen
	
	//method image() = imagen

}

