object posicionCercana {

	method obtener(posicionFinal, posicionAnterior, posicionActual) {
		const diferenciaX = (posicionFinal.x() - posicionAnterior.x())
		const diferenciaY = (posicionFinal.y() - posicionAnterior.y())
		return posicionActual.up(diferenciaY).right(diferenciaX)
	}

}
