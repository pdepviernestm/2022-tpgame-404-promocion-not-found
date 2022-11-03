import wollok.game.*
import config.*

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
    	//game.addVisual(reloj)
		game.onTick(1000,"Empezar temporizador",{self.correrTemporizador()})
	    
	//onTick(milliseconds, name, action)
	//schedule(milliseconds, action)
    }
	
	method correrTemporizador() {
		if(tiempoRestante<=0){
			self.stop()
			//accion nivel
		}
		
		self.setTiempoRestanteContador()
		//reloj.mostrarTiempoRestante()
	}
	
	method stop(){
		game.removeTickEvent("Empezar temporizador")
	}
	
}


object timer inherits Timer(tiempoTotal=60){
	
}

/*object reloj{
	var property position= game.origin()
	const property image="reloj.png"
	//var property segundosRestantes
	method mostrarTiempoRestante(){
		game.say(self,timer.tiempoRestante().toString())
	}
}
*/


class Digito {
	var posicionDigito
	var posicionBase
	var property position = game.origin()
	
	method position()=posicionBase.right(posicionDigito)
	method digito(){
		const numeroString = timer.tiempoRestante().toString()
		return if (numeroString.size() - 1 < posicionDigito)
			"sinNumero"
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

