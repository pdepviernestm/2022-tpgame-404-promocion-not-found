object arriba {

	method posSiguiente(posicion) {
		return posicion.up(1)
	}

}

object abajo {

	method posSiguiente(posicion) {
		return posicion.down(1)
	}

}

object izquierda {

	method posSiguiente(posicion) {
		return posicion.left(1)
	}

}

object derecha {

	method posSiguiente(posicion) {
		return posicion.right(1)
	}

}