import wollok.game.*
import posicionCercana.*
import item.*

object jugador {

	var property velocidad = 100
	var itemActual
	var position = game.origin()
	var posicionAnterior = position     
     
	method tieneItem() = itemActual != null
	
	method position() = position

	method image() = "jugador.png"

	method position(posicionFinal){
		if (!self.colisiona(posicionFinal))
		posicionAnterior = position.clone()
		
		if(!self.tieneItem() && !self.colisiona(posicionFinal)){
		position = posicionFinal
		}
		else if (self.tieneItem() && itemActual.puedeSerLlevado(posicionFinal, posicionAnterior)&& !self.colisiona(posicionFinal)){
		position = posicionFinal
		itemActual.serLlevado(posicionFinal, posicionAnterior)
		} 
	}


    method agarrarItem() {
		const posMasCercana = posicionCercana.obtener(position, posicionAnterior, position)
		const elementosEnEsaDireccion = posMasCercana.allElements()
		if (not (elementosEnEsaDireccion.isEmpty())) {
			itemActual = elementosEnEsaDireccion.first()
 		}
    }

	method soltarItem() {
		itemActual = null
		nivel.ganar()
	}
	
   method colisiona(direccion) {
   	    if (self.tieneItem() && direccion==itemActual.position()){
   	    return false
   	    }
   	    else 
		return nivel.colisionables().any{unColisionable => unColisionable.position() == direccion}
	}
}