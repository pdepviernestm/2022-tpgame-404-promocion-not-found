import wollok.game.*
import item.*
import jugador.*
import powerUp.*
import config.*

class Nivel {
	const property colisionables=[]
	const property muebles=[]
	const property celdasCamion=[]
	var property nivelSiguiente
	
	
	method ejecutar() {
		config.nivelActual(self)
		//self.nivelSiguiente(nivelSiguiente)
		self.cargarNivel()
	}
	
	method agregarBordes(ancho, alto, origenX, origenY) {
		alto.times({ i => colisionables.add(new Borde(position = game.at(origenX, i + origenY - 1)))})
		alto.times({ i => colisionables.add(new Borde(position = game.at(ancho + origenX - 1, i + origenY - 1)))})
		(ancho - 2).times({ j => colisionables.add(new Borde(position = game.at(j + origenX, origenY)))})
		(ancho - 2).times({ j => colisionables.add(new Borde(position = game.at(j + origenX, alto + origenY - 1)))})
	}
	method agregarParedX(ancho, origenX, origenY) {
		ancho.times({i => colisionables.add(new Pared(position = game.at(origenX+i-1, origenY)))})
    }
	
	method agregarParedY(alto,origenX,origenY){
		alto.times({i => colisionables.add(new Pared(position = game.at(origenX,origenY+i-1)))})
	}
	
	
	method crearMueble(x,y,imagen){
		muebles.add(new Item(position = game.at(x,y),image= imagen))
	}
	
	method crearCeldaCamion(x,y,image){
    	celdasCamion.add(new PisoCamion (position = game.at(x,y),imagen = image))
	} 
	
	method agregarColisionable(nuevoColisionable) {
		colisionables.add(nuevoColisionable)
	}

	method todosLosMueblesEstanEnCamion() {
		return muebles.all({ m => m.estaEnElCamion() })
	}

	method ganar() {
		if (self.todosLosMueblesEstanEnCamion()) {
			game.say(jugador, "¡GANASTE! :)")
			game.schedule(2000, { game.stop()})
		}
	}
	method cargarNivel() {
		
	}
	
	method cargarElementosNivel(){
		celdasCamion.forEach({m=>game.addVisual(m)})
		muebles.forEach({m=>game.addVisual(m)})
		muebles.forEach({m=>colisionables.add(m)})
	}
	
	method esPosicionLegal(posicion) = !(config.nivelActual().colisionables().map{c => c.position()}).contains(posicion)
	
	method generarPosicionLegal()
	{
		const posicionX = 0.randomUpTo(config.ancho())
		const posicionY = 0.randomUpTo(config.alto())
		
		if(self.esPosicionLegal(game.at(posicionX, posicionY)))
		{
			return game.at(posicionX, posicionY)
		}
		else return self.generarPosicionLegal()
	}
	
	method crearPowerUps(){
		const powerUp = new VelocidadPower(position = self.generarPosicionLegal())
		game.addVisual(powerUp)
	}
}

object menu inherits Nivel(nivelSiguiente=nivel1){

	method image() = "menu.png"

	method position() = game.origin()

	override method ejecutar() {
		game.addVisual(self)
	}

	method empezarJuego() {
		if (config.nivelActual() == self) {
			game.removeVisual(self)
			nivelSiguiente.ejecutar()
		}
	}


}
	


object nivel1 inherits Nivel(nivelSiguiente=fin){
	
	override method cargarNivel(){

    self.agregarBordes(22,16,-1,-1)
	self.agregarParedY(10,1,3)
	self.agregarParedY(10,10,3)
	self.agregarParedY(2,6,9)
    self.agregarParedX(3,2,3)
	self.agregarParedX(3,7,3)
	self.agregarParedX(8,2,11)
	self.agregarParedX(8,2,12)
	//self.crearMueble(5,7,"caja.png")
	self.crearMueble(8,10,"caja.png")
	self.crearMueble(2,6,"silla_derecha.png")
	self.crearMueble(4,6,"silla_izquierda.png")
	self.crearMueble(3,7,"silla_abajo.png")
	self.crearMueble(3,5,"silla_arriba.png")
    self.crearMueble(3,6,"mesa.png")
	self.agregarParedX(3,16,12) // pared del camion
	self.agregarParedX(3,16,3) // pared del camion
	self.agregarParedY(8,19,4) // pared del camion
	
	self.crearPowerUps()
	
 	/*const pisoCamion_1 = new PisoCamion (position = game.at(0,2),imagen = "camionAtras.png")
    const pisoCamion_2 = new PisoCamion (position = game.at(0,1),imagen = "camionFrente.png")
	*/
	
	
    	/* 
    self.crearCeldaCamion(0,2)	
    self.crearCeldaCamion(0,1)	
    	*/
    self.cargarElementosNivel()
    game.addVisual(jugador)
    game.showAttributes(jugador)
    jugador.ubicarInicio(15,3)
	
	}
}

object fin inherits Nivel (nivelSiguiente=null){
	
}