import wollok.game.*
import direcciones.*
import powerUp.*
import nivel.*
import config.*

class Jugador{
	const property nombre
	var property position = game.at(-1,-1)
	var property vaRapido = false
	var property powerUpActual=null
	var property direccionActual = arriba
	var property direccionAgarre
	var property itemActual	
	var property herramientaActual

	method image() {
		if (!self.tieneItem()) {
			return nombre + direccionActual.toString() + ".png"
		} else return nombre + direccionAgarre.toString() + ".png"
	}
	
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
    
    method tieneHerramienta() = herramientaActual != null
    
	method agarrarItem() {
		if (!self.tieneItem() && self.hayItemEnfrente() && !self.obtenerItemEnfrente().estaSiendoCargado()) {
			game.sound("sonidos/agarrar.mp3").play()
			itemActual = self.obtenerItemEnfrente()
			itemActual.estaSiendoCargado(true)
			direccionAgarre = direccionActual
		} else game.sound("sonidos/agarrar_fail.mp3").play()
	}

	method soltarItem() {
		if (self.tieneItem()) {
			game.sound("sonidos/soltar.mp3").play()
			itemActual.estaSiendoCargado(false)
			itemActual = null
			direccionAgarre = null
			config.nivelActual().ganar()
		}
	}
	method reiniciarItem(){
		if (self.tieneItem()) {
			itemActual = null
			direccionAgarre = null
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
		} else 	return self.obtenerPosEnfrente().allElements().any({ e => config.nivelActual().colisionables().contains(e)
			                                                              || config.jugadores().contains(e)	})
	}	
	//return config.nivelActual().colisionables().any{ colisionable => colisionable.position() == self.obtenerPosEnfrente() }
	
	method agarrarObjeto(objeto)
	{	
		objeto.serAgarrado(self)
	}
	
	method reiniciarPowerUp(){
		if(powerUpActual!=null)
		powerUpActual.quitarPoder(self)
	}
	
}

object jugador inherits Jugador(nombre="jugador_"){

}

object jugador2 inherits Jugador(nombre="jugador2_"){
	
}