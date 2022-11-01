import wollok.game.*
import item.*
import jugador.*

object nivel {
	const property colisionables=[]
	const property muebles=[]
	const property celdasCamion=[]
	
	method ejecutar(){
	const caja_1 = new Item(position = game.at(5,7))
	muebles.add(caja_1)
	const caja_2 = new Item(position = game.at(8,10))
	muebles.add(caja_2)
		
	muebles.forEach({m=>colisionables.add(m)})
	muebles.forEach({m=>game.addVisual(m)})

 	
    const pisoCamion_1 = new PisoCamion (position = game.at(0,2),imagen = "camionAtras.png")
    const pisoCamion_2 = new PisoCamion (position = game.at(0,1),imagen = "camionFrente.png")
    
    
    celdasCamion.add(pisoCamion_1)
    celdasCamion.add(pisoCamion_2)
    
    celdasCamion.forEach({m=>game.addVisual(m)})
    	/* 
    self.crearCeldaCamion(0,2)	
    self.crearCeldaCamion(0,1)	
    	*/
	
	
	self.agregarBordes(22,16,-1,-1)
	self.agregarParedY(10,1,3)
	self.agregarParedY(10,10,3)
	self.agregarParedY(2,6,9)
    self.agregarParedX(3,2,3)
	self.agregarParedX(3,7,3)
	self.agregarParedX(8,2,11)
	self.agregarParedX(8,2,12)
	}

	method agregarBordes(ancho, alto, origenX, origenY) {
		alto.times({ i => colisionables.add(new Borde(position = game.at(origenX, i + origenY - 1)))})
		alto.times({ i => colisionables.add(new Borde(position = game.at(ancho + origenX - 1, i + origenY - 1)))})
		(ancho - 2).times({ j => colisionables.add(new Borde(position = game.at(j + origenX, origenY)))})
		(ancho - 2).times({ j => colisionables.add(new Borde(position = game.at(j + origenX, alto + origenY - 1)))})
	}

	method agregarPared(xInicial, yInicial, xFinal, yFinal) {
		const largoX = (xFinal - xInicial).abs() + 1
		const largoY = (yFinal - yInicial).abs() + 1
		largoX.times({ i => colisionables.add(new Borde(position = game.at(xInicial + i - 1, yInicial)))})
		largoY.times({ i => colisionables.add(new Borde(position = game.at(xInicial, yInicial + i - 1)))})
	}
	
	method agregarParedX(ancho, origenX, origenY) {
	ancho.times({i => colisionables.add(new Pared(position = game.at(origenX+i-1, origenY)))})
    }
	
	method agregarParedY(alto,origenX,origenY){
	alto.times({i => colisionables.add(new Pared(position = game.at(origenX,origenY+i-1)))})
	}
	
	
	
	//otra posibilidad
	method crearItem(x,y){
		colisionables.add(new Item(position = game.at(x,y)))
	}
	
	method crearCeldaCamion(x,y){
    celdasCamion.add(new PisoCamion (position = game.at(x,y),imagen = "celdaCamion.png"))
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

}

