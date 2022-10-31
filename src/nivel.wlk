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

 	
 	const pisoCamion_1 = new PisoCamion (position = game.at(0,2))
    const pisoCamion_2 = new PisoCamion (position = game.at(0,1))
    
    
    celdasCamion.add(pisoCamion_1)
    celdasCamion.add(pisoCamion_2)
    
    celdasCamion.forEach({m=>game.addVisual(m)})
    	/* 
    self.crearCeldaCamion(0,2)	
    self.crearCeldaCamion(0,1)	
    	*/
	
	
	self.agregarBordes(22,16,-1,-1)
	
	
	}
	
	method agregarBordes(ancho, alto, origenX, origenY) {
	alto.times({i => colisionables.add(new Borde(position = game.at(origenX, i + origenY - 1)))})
	alto.times({i => colisionables.add(new Borde(position = game.at(ancho + origenX - 1, i + origenY - 1)))})

	(ancho-2).times({j => colisionables.add(new Borde(position = game.at(j + origenX, origenY)))})
	(ancho-2).times({j => colisionables.add(new Borde(position = game.at(j + origenX, alto + origenY - 1)))})
	}
	
	
	//otra posibilidad
	method crearItem(x,y){
		colisionables.add(new Item(position = game.at(x,y)))
	}
	
	method crearCeldaCamion(x,y){
    celdasCamion.add(new PisoCamion (position = game.at(0,1)))
	} 
	
	method agregarColisionable(nuevoColisionable) {
	    colisionables.add(nuevoColisionable)
	}
	
	method todosLosMueblesEstanEnCamion(){
		return muebles.all({m=>m.estaEnElCamion()})
	}
	method ganar() {
       if (self.todosLosMueblesEstanEnCamion()){
       	game.say(jugador,"¡GANASTE! :)")
        game.schedule(2000, { game.stop()})       }
	}
	
}
