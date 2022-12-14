import wollok.game.*
import config.*
import nivel.*

class Timer{
	var property tiempoTotal //en segundos
    var property contador=0
    var property tiempoRestante=tiempoTotal
    
    method setTiempoRestanteContador(){
    	tiempoRestante-=1
    	contador+=1
    }
    
    method empezar(){
    	tiempoTotal=config.nivelActual().tiempoNivel()
    	tiempoRestante=tiempoTotal
		game.onTick(1000,"Empezar temporizador",{self.correrTemporizador()})

    }
	
	method correrTemporizador() {
		if(tiempoRestante<=0){
			self.stop()
			config.nivelActual().timeOver()
		}
		self.setTiempoRestanteContador()
	}
	
	method stop(){
		game.removeTickEvent("Empezar temporizador")
	}
}

object timer inherits Timer(tiempoTotal=60){
}


class Digito {
	var posicionDigito
	var posicionBase
	var property position = game.origin()
	
	method position()=posicionBase.right(posicionDigito)
	method digito(){
		const numeroString = timer.tiempoRestante().toString()
		return if (numeroString.size() - 1 < posicionDigito)
			"sinImagen"
		else
			numeroString.charAt(posicionDigito)
	}
	method image() = "numeros/"+self.digito()+".png"
}


object digitosReloj{
	method generarDigitos(numeroMax,posicion){
		var cantidadDigitos=numeroMax.toString().size()
		cantidadDigitos.times({i=>game.addVisual(new Digito(posicionDigito=i-1,posicionBase=posicion))})
	}
}