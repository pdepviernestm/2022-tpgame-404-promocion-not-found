import wollok.game.*
import posicionCercana.*

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
		position = posicionFinal
		if (self.tieneItem()) {
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

}

