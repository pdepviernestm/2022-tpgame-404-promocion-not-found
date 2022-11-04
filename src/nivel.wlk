import wollok.game.*
import item.*
import jugador.*
import powerUp.*
import config.*
import timer.*

class Nivel {
	const property colisionables=[]
	const property muebles=[]
	const property celdasCamion=[]
	const property paredes=[]
	const property powerUps=[]
    var property tiempoNivel
	var property nivelSiguiente
	
	
	method ejecutar() {
		config.nivelActual(self)
		//self.nivelSiguiente(nivelSiguiente)
		self.cargarNivel()
	}
	
	method agregarBordes(ancho, alto, origenX, origenY) {
		alto.times({ i => paredes.add(new Borde(position = game.at(origenX, i + origenY - 1)))})
		alto.times({ i => paredes.add(new Borde(position = game.at(ancho + origenX - 1, i + origenY - 1)))})
		(ancho - 2).times({ j => paredes.add(new Borde(position = game.at(j + origenX, origenY)))})
		(ancho - 2).times({ j => paredes.add(new Borde(position = game.at(j + origenX, alto + origenY - 1)))})
	}
	method agregarParedX(ancho, origenX, origenY) {
		ancho.times({i => paredes.add(new Pared(position = game.at(origenX+i-1, origenY)))})
    }
	
	method agregarParedY(alto,origenX,origenY){
		alto.times({i => paredes.add(new Pared(position = game.at(origenX,origenY+i-1)))})
	}
	
	
	method crearMueble(x,y,imagen){
		muebles.add(new Item(position = game.at(x,y),image= imagen))
	}
	
	method crearCeldaCamion(x,y,image){
    	celdasCamion.add(new PisoCamion(position = game.at(x,y)))
	} // ,imagen = image
	
	method agregarCeldaCamion(alto,origenX,origenY){
		alto.times({i => celdasCamion.add(new PisoCamion(position = game.at(origenX,origenY+i-1)))})
	}
	
	method agregarColisionable(nuevoColisionable) {
		colisionables.add(nuevoColisionable)
	}

	method todosLosMueblesEstanEnCamion() {
		return muebles.all({ m => m.estaEnElCamion() })
	}

	method ganar() {
		if (self.todosLosMueblesEstanEnCamion()) {
			game.say(jugador, "¡BIEN HECHO! :)")
			game.onTick(2000, "espera", {self.cargarSiguiente(nivelSiguiente)
				                         game.removeTickEvent("espera")})
		}
	}
	method cargarNivel() {
		
	}
	
	method cargarElementosNivel(){
		muebles.forEach({m=>game.addVisual(m)})
		muebles.forEach({m=>colisionables.add(m)})
		paredes.forEach({p=>game.addVisual(p)})
		paredes.forEach({p=>colisionables.add(p)})
		powerUps.forEach({pU=>game.addVisual(pU)})
	}
	method eliminarElementosNivel() {
		const elementosNivel=[colisionables,powerUps].flatten()
		elementosNivel.forEach{ e => game.removeVisual(e)}
		colisionables.clear()
		muebles.clear()
		celdasCamion.clear()
		paredes.clear()
		powerUps.clear()
		game.removeVisual(jugador)
	}
	
	method cargarSiguiente(nivel) {
		self.eliminarElementosNivel()
		nivelSiguiente.ejecutar()
	}
	
	method esPosicionDisponible(posicion) = !(config.nivelActual().colisionables()).any{ colisionable => colisionable.position() == posicion }
	
	method generarPosicionDisponible()
	{
		const posicionX = 0.randomUpTo(config.ancho()).roundUp()
		const posicionY = 0.randomUpTo(config.alto()).roundUp()
		
		if(self.esPosicionDisponible(game.at(posicionX, posicionY)))
		{
			return game.at(posicionX, posicionY)
		}
		else return self.generarPosicionDisponible()
	}
	
	method crearPowerUp(){
		powerUps.add(new VelocidadPower(position = self.generarPosicionDisponible()))
	}
}

object menu inherits Nivel(nivelSiguiente=nivel1,  tiempoNivel=0){

	method image() = "prototipo_menu.png"

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
	


object nivel1 inherits Nivel(nivelSiguiente=nivel2, tiempoNivel=60){
	
	override method cargarNivel(){

    self.agregarBordes(22,16,-1,-1)
	self.agregarParedY(10,1,3)
	self.agregarParedY(10,10,3)
	self.agregarParedY(2,6,9)
    self.agregarParedX(3,2,3)
	self.agregarParedX(3,7,3)
	self.agregarParedX(8,2,11)
	self.agregarParedX(8,2,12)
	/*self.crearMueble(8,10,"caja.png")
	self.crearMueble(2,6,"silla_derecha.png")
	self.crearMueble(4,6,"silla_izquierda.png")
	self.crearMueble(3,7,"silla_abajo.png")
	self.crearMueble(3,5,"silla_arriba.png")*/
    self.crearMueble(3,6,"mesa.png")
	self.agregarParedX(3,16,12) // pared del camion
	self.agregarParedX(3,16,3) // pared del camion
	self.agregarParedY(8,19,4) // pared del camion
	self.agregarCeldaCamion(8,16,4)
	self.agregarCeldaCamion(8,17,4)
	self.agregarCeldaCamion(8,18,4)
	
	self.crearPowerUp()
	
    self.cargarElementosNivel()
    game.addVisual(jugador)
    game.showAttributes(jugador)
    jugador.ubicarInicio(15,3)
	digitosReloj.generarDigitos(tiempoNivel, game.at(7,12))
    timer.empezar()
	}
}

object nivel2 inherits Nivel (nivelSiguiente=fin, tiempoNivel=90){
	

	override method cargarNivel(){
	game.addVisual(fondo2)
	self.agregarBordes(22,16,-1,-1)
	self.agregarCeldaCamion(8,0,4)
	self.agregarCeldaCamion(8,1,4)
	self.agregarCeldaCamion(8,2,4)
	//paredes camion
	self.agregarParedX(3,0,3)
	self.agregarParedX(3,0,12)
	//no agrego Y porque es borde de mapa
	//paredes casa
	self.agregarParedY(7,5,7)
	self.agregarParedX(13,5,13)
	self.agregarParedX(13,5,14)
	self.agregarParedX(13,5,12)
	self.agregarParedY(2,9,10)
	self.agregarParedX(9,5,7)
	self.agregarParedX(4,7,6)
	self.agregarParedX(4,7,5)
	self.agregarParedY(3,13,5)
	self.agregarParedY(3,16,5)
	self.agregarParedY(7,17,7)
	self.crearMueble(7,10,"mesa.png")
	self.crearMueble(10,11,"heladera.png")
	self.crearMueble(16,8,"silla_izquierda.png")
	self.crearMueble(16,9,"silla_izquierda.png")
	self.crearMueble(14,10,"caja.png")
	
	self.cargarElementosNivel()
	game.addVisual(jugador)
	game.showAttributes(jugador)
    jugador.ubicarInicio(15,3)
	}
	
}

object fin inherits Nivel (nivelSiguiente=null,tiempoNivel=0){
	
}

object fondo2 {
	const property position=game.at(-1,-1)
	const property image="nivel_2.png"
}