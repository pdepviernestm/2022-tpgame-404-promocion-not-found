import wollok.game.*
import direcciones.*
import jugador.*

object config {

	const property alto = 14
	const property ancho = 20
	const property celdas = 50
	
	method teclasJugador() {
		keyboard.up().onPressDo{ jugador.mover(arriba)}
		keyboard.down().onPressDo{ jugador.mover(abajo)}
		keyboard.left().onPressDo{ jugador.mover(izquierda)}
		keyboard.right().onPressDo{ jugador.mover(derecha)}
		keyboard.shift().onPressDo{ jugador.agarrarItem()}
		keyboard.control().onPressDo{ jugador.soltarItem()}
	}
}

