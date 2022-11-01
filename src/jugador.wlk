import wollok.game.*
import direcciones.*
import posicionCercana.*
import nivel.*
import config.*

object jugador {

	var position = game.origin()
	var velocidad = 100
	var property direccionActual = arriba
	var property direccionAgarre
	var property itemActual

	method image() {
		if (!self.tieneItem()) {
			return "jugador_" + direccionActual.toString() + ".png"
		} else return "jugador_" + direccionAgarre.toString() + ".png"
	}
	
	/*  Si el string que devuelve imagen es "jugador_direccion[].png"
	method image() {
		if (!self.tieneItem()) {
			return "jugador_" + direccionActual.toString().reverse().drop(2).reverse() + ".png"
		} else return "jugador_" + direccionAgarre.toString().reverse().drop(2).reverse() + ".png"
	}
	
	*/

	method position() = position

	method setearDireccion(direccion) {
		direccionActual = direccion
	}

	method mover(direccion) {
		self.setearDireccion(direccion)
		if (!self.colisiona()) {
			if (!self.tieneItem())
			    position = direccion.posSiguiente(position)
			if (self.tieneItem() && itemActual.puedeSerLlevado(self)) {
			    position = direccion.posSiguiente(position)
				itemActual.serLlevado(self)}
			else if (self.tieneItem() && !itemActual.puedeSerLlevado(self)&& direccionAgarre!=direccionActual)
			        self.soltarItem()
		}
	}

method mover1(direccion) {
		self.setearDireccion(direccion)
		if (!self.colisiona()) {
			position = direccion.posSiguiente(position)
			if (self.tieneItem() && itemActual.puedeSerLlevado(self)) 
				itemActual.serLlevado(self)
			else if (self.tieneItem() && !itemActual.puedeSerLlevado(self)&& direccionAgarre!=direccionActual)
			        self.soltarItem()
		}
	}

	method tieneItem() = itemActual != null

	method agarrarItem() {
		if (!self.tieneItem() && self.hayItemEnfrente()) {
			itemActual = self.obtenerItemEnfrente()
			direccionAgarre = direccionActual
		}
	}

	method soltarItem() {
		if (self.tieneItem()) {
			itemActual = null
			direccionAgarre = null
			config.nivelActual().ganar()
		}
	}

	method obtenerPosEnfrente() {
		return direccionActual.posSiguiente(position)
	}

	method hayItemEnfrente() {
		return !self.obtenerPosEnfrente().allElements().isEmpty()
	}

	method obtenerItemEnfrente() {
		const posicionEnfrente = self.obtenerPosEnfrente()
		return posicionEnfrente.allElements().first()
	}

	method itemActualEnfrente() {
		return self.obtenerPosEnfrente() == itemActual.position()
	}

	method colisiona() {
		if (self.tieneItem() && self.itemActualEnfrente()) {
			return false
		} else return nivel.colisionables().any{ colisionable => colisionable.position() == self.obtenerPosEnfrente() }
	}

}

