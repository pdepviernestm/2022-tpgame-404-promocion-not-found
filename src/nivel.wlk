import wollok.game.*
import item.*

object nivel {
	const property colisionables=[]
	
	method ejecutar(){
	const caja_1 = new Item(position = game.center())
	colisionables.add(caja_1)
	const caja_2 = new Item(position = game.center().up(1).right(1))
	colisionables.add(caja_2)
		
	game.addVisual(caja_1)
	game.addVisual(caja_2)
	}
	
	//otra posibilidad
	method crearItem(x,y){
		colisionables.add(new Item(position = game.at(x,y)))
	}
	method agregarColisionable(nuevoColisionable) {
	    colisionables.add(nuevoColisionable)
	}
	
	

}
