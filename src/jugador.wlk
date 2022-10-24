import wollok.game.*
import posicionCercana.*
import item.*
import nivel.*

object jugador {

	var property velocidad = 100
	var itemActual
	var position = game.origin()
	var posicionInicial = position
     
     
	method tieneItem() = itemActual != null

	method position() = position

	method image() = "jugador.png"

	method position(posicionFinal) {
		posicionInicial = position.clone()
		if(!self.tieneItem()){
		position = posicionFinal
		}
		else if (self.tieneItem() && itemActual.puedeSerLlevado(posicionFinal, posicionInicial)) {
		position = posicionFinal
		itemActual.serLlevado(posicionFinal, posicionInicial)
		} 
	}

	method agarrarItem() {
		const posMasCercana = posicionCercana.obtener(position, posicionInicial, position)
		const elementosEnEsaDireccion = posMasCercana.allElements()
		if (not (elementosEnEsaDireccion.isEmpty())) {
			itemActual = elementosEnEsaDireccion.first()
		}
	}

	method soltarItem() {
		itemActual = null
	}
	
   /* method colisiona(direccion) {
    	if(itemActual){
    	return 7
    	}
    	else
		return colisionables.any{ unColisionable => unColisionable.position() == direccion.posicionSiguiente(self) }
	}*/
	

}


