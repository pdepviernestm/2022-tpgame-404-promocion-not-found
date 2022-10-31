import wollok.game.*
import direcciones.*
import nivel.*

class Item {

	var property position = game.center()

	method image() = "caja.png"

	method puedeSerLlevado(jugador) {
		return !self.colisiona(jugador.direccionActual())
	}

	method serLlevado(jugador) {
		position = jugador.direccionAgarre().posSiguiente(jugador.position())
	}

	method colisiona(direccion) {
		return nivel.colisionables().any{ colisionable => colisionable.position() == direccion.posSiguiente(position) }
	}

	method estaEnElCamion() {
		return nivel.celdasCamion().any({ c => c.position() == position })
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
	
	method image() = "celdaCamion.png"

}

