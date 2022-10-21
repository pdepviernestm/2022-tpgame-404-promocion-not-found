import wollok.game.*
import posicionCercana.*

class Item {

	var property position = game.center()

	method image() = "caja.png"

	method serLlevado(posFinalPortador, posInicialPortador) {
		position = posicionCercana.obtener(posFinalPortador, posInicialPortador, position)
	}

}
