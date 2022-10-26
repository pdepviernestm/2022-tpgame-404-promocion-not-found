object posicionCercana {

	method obtener(posicionFinal, posicionInicial, posicionActual) {
		const diferenciaX = (posicionFinal.x() - posicionInicial.x())
		const diferenciaY = (posicionFinal.y() - posicionInicial.y())
		return posicionActual.up(diferenciaY).right(diferenciaX)
	}



}



