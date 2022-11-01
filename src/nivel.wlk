import wollok.game.*
import item.*
import jugador.*
import config.*

class Nivel {
	const property colisionables=[]
	const property muebles=[]
	const property celdasCamion=[]
	var property nivelSiguiente
	
	
	method ejecutar() {
		config.nivelActual(self)
		self.nivelSiguiente(nivelSiguiente)
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
	
	
	method crearMueble(x,y){
		muebles.add(new Item(position = game.at(x,y)))
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
	
	
}

object nivel inherits Nivel(nivelSiguiente=fin){
	
	override method cargarNivel(){

    self.agregarBordes(22,16,-1,-1)
	self.agregarParedY(10,1,3)
	self.agregarParedY(10,10,3)
	self.agregarParedY(2,6,9)
    self.agregarParedX(3,2,3)
	self.agregarParedX(3,7,3)
	self.agregarParedX(8,2,11)
	self.agregarParedX(8,2,12)
	self.crearMueble(5,7)
	self.crearMueble(8,10)

 	/*const pisoCamion_1 = new PisoCamion (position = game.at(0,2),imagen = "camionAtras.png")
    const pisoCamion_2 = new PisoCamion (position = game.at(0,1),imagen = "camionFrente.png")
	*/
	self.crearCeldaCamion(0,2,"camionAtras.png")
	self.crearCeldaCamion(0,1,"camionFrente.png")
    	/* 
    self.crearCeldaCamion(0,2)	
    self.crearCeldaCamion(0,1)	
    	*/
    self.cargarElementosNivel()
	}
}

object fin inherits Nivel (nivelSiguiente=null){
	
}