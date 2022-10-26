import wollok.game.*
import posicionCercana.*
import nivel.*

class Item {

	var property position = game.center()

	method image() = "caja.png"
	
	method puedeSerLlevado(posFinalPortador, posInicialPortador){
		return !self.colisiona(posicionCercana.obtener(posFinalPortador, posInicialPortador, position))
	}

	method serLlevado(posFinalPortador, posInicialPortador) {
		position = posicionCercana.obtener(posFinalPortador, posInicialPortador, position)
	}
	
	 method colisiona(direccion) {
		return nivel.colisionables().any{ unColisionable => unColisionable.position() == direccion }
	}
	
	method estaEnElCamion(){
		return nivel.celdasCamion().any({c=>c.position()==position})
	}

}

class Borde {
	var property position
}

class PisoCamion {
	var property position
}

	