import wollok.game.*
import direcciones.*
import jugador.*
import nivel.*

object config {

	const property alto = 14
	const property ancho = 20
	const property celdas = 50
	var property nivelActual = menu
	var property dosJugadores = false
	const property jugadores = [jugador,jugador2]
	
	method teclasJugador() {
		keyboard.up().onPressDo{ jugador.mover(arriba)}
		keyboard.down().onPressDo{ jugador.mover(abajo)}
		keyboard.left().onPressDo{ jugador.mover(izquierda)}
		keyboard.right().onPressDo{ jugador.mover(derecha)}
		keyboard.shift().onPressDo{ jugador.agarrarItem()}
		keyboard.control().onPressDo{ jugador.soltarItem()}
		keyboard.w().onPressDo{ jugador2.mover(arriba)}
		keyboard.s().onPressDo{ jugador2.mover(abajo)}
		keyboard.a().onPressDo{ jugador2.mover(izquierda)}
		keyboard.d().onPressDo{ jugador2.mover(derecha)}
		keyboard.space().onPressDo{ jugador2.agarrarItem()}
		keyboard.e().onPressDo{ jugador2.soltarItem()}
		keyboard.enter().onPressDo{ nivelActual.empezarJuego()}
		keyboard.num1().onPressDo{ nivelActual.elegirUnJugador()}
		keyboard.num2().onPressDo{ nivelActual.elegirDosJugadores()}
	}
	
	method nivelActual(unNivel){
		nivelActual=unNivel
	}
	
	method jugadorContrario(unJugador){
		 if (unJugador.nombre()=="jugador_") return jugador2
		 else return jugador
	}
}

