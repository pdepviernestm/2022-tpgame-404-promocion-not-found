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
	return game.getObjectsIn(direccion.posSiguiente(position)).any({ e => config.nivelActual().colisionables().contains(e)})
	} 
	//return config.nivelActual().colisionables().any{ colisionable => colisionable.position() == direccion.posSiguiente(position) }

	method estaEnElCamion(){
		return config.nivelActual().celdasCamion().any({ c => c.position() == position })
	}

}

class Borde {

	var property position
    method image() = "sinImagen.png"
}

class Pared {

	var property position
    method image() = "sinImagen.png"
}

class PisoCamion {

	var property position = game.center()
	
	//var property imagen
	
	//method image() = imagen

}

