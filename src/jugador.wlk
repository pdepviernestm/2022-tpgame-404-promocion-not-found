import wollok.game.*
import direcciones.*
import powerUp.*
import nivel.*
import config.*

object jugador {

	var property position = game.origin()
	var property vaRapido = false
	var powerUpActual
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
    method ubicarInicio(x,y){
		position = game.at(x, y)
		direccionActual = abajo
	}
    
	method position() = position
    
	method setearDireccion(direccion) {
		direccionActual = direccion
	}
	
	method mover(direccion){
    	if(vaRapido){
    		self.moverAumentado(direccion)
    	}
    	else self.moverNormal(direccion)
    }

	method moverNormal(direccion) {
		self.setearDireccion(direccion)
		if (!self.colisiona()) {
			if (!self.tieneItem())
			    position = direccion.posSiguiente(position)
			if (self.tieneItem() && itemActual.puedeSerLlevado(self)) {
			    position = direccion.posSiguiente(position)
				itemActual.serLlevado(self)}
			else if (self.tieneItem() && !itemActual.puedeSerLlevado(self)&& direccionAgarre!=direccionActual){
			        self.soltarItem()
			        position = direccion.posSiguiente(position)}
		}
	}
    
    method moverAumentado(direccion){
    	self.moverNormal(direccion)
    	self.moverNormal(direccion)
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
		return posicionEnfrente.allElements().filter({e=>config.nivelActual().muebles().contains(e)}).first()
	}

	method itemActualEnfrente() {
		return self.obtenerPosEnfrente() == itemActual.position()
	}

	method colisiona() {
		if (self.tieneItem() && self.itemActualEnfrente()) {
			return false
		} else 	return self.obtenerPosEnfrente().allElements().any({ e => config.nivelActual().colisionables().contains(e)})
	}	
	//return config.nivelActual().colisionables().any{ colisionable => colisionable.position() == self.obtenerPosEnfrente() }

	
	method agarrarPoder(powerUp)
	{	
		powerUpActual = powerUp
		powerUpActual.darPoder(self)
	}

	method reiniciarPowerUp(){
		if(!powerUpActual)
		powerUpActual.quitarPoder(self)
	}
	
}

