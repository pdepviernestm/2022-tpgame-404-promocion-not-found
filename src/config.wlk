import wollok.game.*
import direcciones.*
import jugador.*
import nivel.*

object config {

	const property alto = 14
	const property ancho = 20
	const property celdas = 50
	var property nivelActual = nivel
	
	method teclasJugador() {
		keyboard.up().onPressDo{ jugador.mover(arriba)}
		keyboard.down().onPressDo{ jugador.mover(abajo)}
		keyboard.left().onPressDo{ jugador.mover(izquierda)}
		keyboard.right().onPressDo{ jugador.mover(derecha)}
		keyboard.shift().onPressDo{ jugador.agarrarItem()}
		keyboard.control().onPressDo{ jugador.soltarItem()}
	}
	
	method nivelActual(unNivel){
		nivelActual=unNivel
	}
}

