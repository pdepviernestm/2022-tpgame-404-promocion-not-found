import wollok.game.*
import item.*
import jugador.*
import powerUp.*
import config.*
import timer.*
import score.*
import herramienta.*

class Nivel {
	const property colisionables=[]
	const property muebles=[]
	const property celdasCamion=[]
	const property paredes=[]
	const property powerUps=[]
	const property herramientas=[]
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
	
	
	method crearMueble(x,y,imagen,esPesado){
		muebles.add(new Item(position = game.at(x,y),image= imagen, pesado = esPesado))
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
			timer.stop()
			game.say(jugador, "¡BIEN HECHO! :)")
			game.onTick(2000, "espera", {self.cargarSiguiente(nivelSiguiente)
				                         game.removeTickEvent("espera")})
		}
	}
	
	method aumentarScore(unMueble) {
		const jugadores = config.jugadores().size()
		const puntosParaGuante = 3
		
		if (unMueble.estaEnElCamion()){
			score.aumentar()
			if(score.puntos() == puntosParaGuante*jugadores) {
				jugadores.times({i => self.crearGuante()})
				self.cargarHerramientas()
			}
		}
	}

	method cargarNivel() {
	}
	
	method cargarElementosNivel(){
		muebles.forEach({m=>game.addVisual(m)})
		muebles.forEach({m=>colisionables.add(m)})
		paredes.forEach({p=>game.addVisual(p)})
		paredes.forEach({p=>colisionables.add(p)})		

	}
	
	method cargarPowerUps(){
		powerUps.forEach({pU=>game.addVisual(pU)})
	}
	
	method cargarHerramientas(){
		herramientas.forEach({h=>game.addVisual(h)})
	}
	
	
	method agregarJugador1(x,y){
		game.addVisual(jugador)
        game.showAttributes(jugador)
        jugador.ubicarInicio(x,y)
        game.onCollideDo(jugador, {objeto => jugador.agarrarObjeto(objeto)})
	}

    method agregarJugador2(x,y){
    	if(config.dosJugadores()){
    		game.addVisual(jugador2)
            game.showAttributes(jugador2)
            jugador2.ubicarInicio(x,y)
            game.onCollideDo(jugador2, {objeto => jugador2.agarrarObjeto(objeto)})
		}
    }	
	method eliminarJugadores(){
		if(config.dosJugadores()){
			game.removeVisual(jugador)
			game.removeVisual(jugador2)
		}else game.removeVisual(jugador)
	}
	
	method reiniciarHerramientasJugadores(){
		if(config.dosJugadores()){
			jugador.herramientaActual(null)
			jugador2.herramientaActual(null)
		}else jugador.herramientaActual(null)
	}
	
	method eliminarElementosNivel() {
		const elementosNivel=[colisionables,powerUps,herramientas].flatten()
		elementosNivel.forEach{ e => game.removeVisual(e)}
		colisionables.clear()
		muebles.clear()
		celdasCamion.clear()
		paredes.clear()
		powerUps.clear()
		herramientas.clear()
		//game.removeVisual(jugador)
		self.eliminarJugadores()
		self.reiniciarHerramientasJugadores()
	}
	
	method cargarSiguiente(nivel) {
		self.eliminarElementosNivel()
        self.reiniciarJugadores()
        score.resetear()
        nivelSiguiente.ejecutar()
	}
	
	method esPosicionDisponible(posicion) = !(config.nivelActual().colisionables()).any{ colisionable => colisionable.position() == posicion }
	
	method generarPosicionDisponible()
	{
		const posicionX = 0.randomUpTo(config.ancho()-1).roundUp()
		const posicionY = 0.randomUpTo(config.alto()-1).roundUp()
		
		if(self.esPosicionDisponible(game.at(posicionX, posicionY)))
		{
			return game.at(posicionX, posicionY)
		}
		else return self.generarPosicionDisponible()
	}
	
	method crearPowerUpVelocidad(){
		powerUps.add(new VelocidadPower(position = self.generarPosicionDisponible()))
	}
	
	method crearPowerUpMalo(){
		powerUps.add(new PowerMalo(position = self.generarPosicionDisponible()))
	}
	
	method crearGuante(){
		game.sound("sonidos/aparecer_herramienta.mp3").play()
		herramientas.add(new Guante(position = self.generarPosicionDisponible()))
	}
	
	method reiniciarJugadores(){
		jugador.reiniciarItem()
		jugador.reiniciarPowerUp()
		if(config.dosJugadores()){
		jugador2.reiniciarItem()
		jugador2.reiniciarPowerUp()
		}
	}
	
	method timeOver(){
		self.eliminarElementosNivel()
        self.reiniciarJugadores()
        score.resetear()
		gameOver.nivelSiguiente(self)
		config.cancionDeFondo().pause()
		config.nivelActual(gameOver)
		gameOver.ejecutar()
	}
}

object menu inherits Nivel(nivelSiguiente=nivel1,  tiempoNivel=0){

	method image() = "prototipo_menu.png"

	method position() = game.origin()

	override method ejecutar() {
		game.addVisual(self)
	}
    
    method elegirUnJugador() {
		if (config.nivelActual() == self) {
			config.dosJugadores(false)
		}
	}
	
    method elegirDosJugadores() {
		if (config.nivelActual() == self) {
			config.jugadores().add(jugador2)
			config.dosJugadores(true)
		}
	}
    
	method empezarJuego() {
		if (config.nivelActual() == self) {
			game.removeVisual(self)
			nivelSiguiente.ejecutar()
			config.cancionDeFondo().play()
		}
	}

}
	


object nivel1 inherits Nivel(nivelSiguiente=nivel2, tiempoNivel=80){
	
	override method cargarNivel(){

    self.agregarBordes(22,16,-1,-1)
    self.agregarParedX(2,0,0) //para el reloj
	self.agregarParedY(10,1,3)
	self.agregarParedY(10,10,3)
	self.agregarParedY(2,6,9)
    self.agregarParedX(3,2,3)
	self.agregarParedX(3,7,3)
	self.agregarParedX(8,2,11)
	self.agregarParedX(8,2,12)
	self.agregarParedX(2,2,9)
	
	self.crearMueble(7,10,"biblioteca.png", true)
	self.crearMueble(8,10,"lampara.png", false)
	self.crearMueble(9,9,"caja.png", false)
	self.crearMueble(9,10,"cama.png", true)
	self.crearMueble(2,10,"heladera.png", true)
	self.crearMueble(3,10,"horno.png", true)
	self.crearMueble(8,4,"sillon.png", true)
	self.crearMueble(8,5,"mesa_gris_redonda.png", false)
	self.crearMueble(9,5,"mesa_gris_redonda.png", false)
	self.crearMueble(9,6,"televisor.png", false)
	self.crearMueble(2,6,"silla_derecha.png", false)
	self.crearMueble(4,6,"silla_izquierda.png", false)
	self.crearMueble(3,7,"silla_abajo.png", false)
	self.crearMueble(3,5,"silla_arriba.png", false)
    self.crearMueble(3,6,"mesa.png", true)
	self.agregarParedX(3,16,12) // pared del camion
	self.agregarParedX(3,16,3) // pared del camion
	self.agregarParedY(8,19,4) // pared del camion
	self.agregarCeldaCamion(8,16,4)
	self.agregarCeldaCamion(8,17,4)
	self.agregarCeldaCamion(8,18,4)
	
    self.cargarElementosNivel()
    self.crearPowerUpVelocidad()
	self.crearPowerUpVelocidad()
	self.crearPowerUpVelocidad()
	self.crearPowerUpMalo()
	self.crearPowerUpMalo()
    self.cargarPowerUps()
    /*game.addVisual(jugador)
    game.showAttributes(jugador)
    jugador.ubicarInicio(15,3)*/
    self.agregarJugador1(15,3)
    self.agregarJugador2(13,3)
	digitosReloj.generarDigitos(tiempoNivel, game.origin())
    timer.empezar()
	}
}

object nivel2 inherits Nivel (nivelSiguiente=nivel3, tiempoNivel=90){
	

	override method cargarNivel(){
	game.addVisual(fondo2)
	self.agregarBordes(22,16,-1,-1)
    self.agregarParedX(2,0,0) //para el reloj
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
	self.crearMueble(10,11,"heladera.png", true)
	self.crearMueble(7,11,"televisor.png", false)
	self.crearMueble(7,10,"mesa_redonda.png", false)
	self.crearMueble(7,9,"silla_arriba.png", false)
	self.crearMueble(6,11,"parlante.png", false)
	self.crearMueble(8,11,"parlante.png", false)
	self.crearMueble(11,11,"horno.png", true)
	self.crearMueble(12,10,"silla_naranja_izquierda.png", false)
	self.crearMueble(10,10,"silla_naranja_derecha.png", false)
	self.crearMueble(11,10,"mesa_gris_redonda.png", false)
	self.crearMueble(15,11,"biblioteca.png", false)
	self.crearMueble(14,11,"lampara.png", false)
	self.crearMueble(16,8,"caja.png", false)
	self.crearMueble(6,8,"caja.png", false)
	self.crearMueble(8,6,"baniera.png", true)
	self.crearMueble(16,9,"sillon_izquierda.png", true)
	self.crearMueble(14,9,"mesa.png", true)
	self.cargarElementosNivel()
	
	self.crearPowerUpVelocidad()
	self.crearPowerUpVelocidad()
	self.crearPowerUpVelocidad()
	self.crearPowerUpVelocidad()
	self.crearPowerUpMalo()
	self.crearPowerUpMalo()
    self.cargarPowerUps()
    
	/*game.addVisual(jugador)
	game.showAttributes(jugador)
    jugador.ubicarInicio(15,3)*/
    self.agregarJugador1(15,3)
    self.agregarJugador2(13,3)
    
    digitosReloj.generarDigitos(tiempoNivel, game.origin())
    timer.empezar()
	}
	
	override method eliminarElementosNivel(){
		super()
		game.removeVisual(fondo2)
	}
}

object nivel3 inherits Nivel (nivelSiguiente=fin, tiempoNivel=60){
	override method cargarNivel(){
		game.addVisual(fondo3)
		self.agregarBordes(22,16,-1,-1)
        self.agregarParedX(2,0,0) // reloj
        
        self.agregarParedY(10,1,1)
        self.agregarParedY(7,10,4)
        self.agregarParedY(2,7,7)
        self.agregarParedY(2,4,7)
        self.agregarParedX(10,2,1)
        self.agregarParedX(8,2,9)
        self.agregarParedX(8,2,10)
        self.agregarParedX(3,2,5)
        self.agregarParedX(3,7,5)
        self.agregarParedX(2,2,4)
        self.agregarParedX(1,11,4)
        self.agregarParedX(3,17,1)
        self.agregarParedX(3,17,10)
        
        self.agregarCeldaCamion(8,17,2)
        self.agregarCeldaCamion(8,18,2)
        self.agregarCeldaCamion(8,19,2)
        
        self.crearMueble(4,4,"horno.png", true)
        self.crearMueble(2,8, "escritorio_con_pc.png", true)
        self.crearMueble(2,7, "silla_arriba.png", false)
        self.crearMueble(3,7, "silla_arriba.png", false)
        self.crearMueble(8,7,"cama_verde.png", true)
        self.crearMueble(9,8,"armario.png", true)
        self.crearMueble(2,2,"silla_naranja_derecha.png", false)
        self.crearMueble(4,2,"silla_naranja_izquierda.png", false)
        self.crearMueble(3,2,"mesa_redonda.png", false)
        self.crearMueble(7,4,"lampara.png", false)
        self.crearMueble(8,4,"biblioteca.png", true)
        self.crearMueble(9,4,"biblioteca.png", true)
        self.crearMueble(8,2,"sillon.png", true)
        self.crearMueble(5,8,"baniera.png", true)
        self.crearMueble(6,7,"inodoro_izquierda.png", false)
		self.cargarElementosNivel()
   		
   		self.crearPowerUpVelocidad()
		self.crearPowerUpVelocidad()
		self.crearPowerUpVelocidad()
		self.crearPowerUpMalo()
		self.crearPowerUpMalo()
		self.crearPowerUpMalo()
    	self.cargarPowerUps()
   	               
		self.agregarJugador1(15,3)
   		self.agregarJugador2(13,3)		
   		
   		digitosReloj.generarDigitos(tiempoNivel, game.origin())
    	timer.empezar()
	}
}

object fin inherits Nivel (nivelSiguiente=null,tiempoNivel=0){
	
}

object fondo2 {
	const property position=game.at(-1,-1)
	const property image="nivel_2.png"
}

object fondo3 {
	const property position=game.at(-1,-1)
	const property image="nivel_3.png"
}

object gameOver inherits Nivel(nivelSiguiente=null,tiempoNivel=0){
	const property position=game.origin()
	const property image="reintentar_nivel.png"
	
	override method ejecutar() {
		game.addVisual(self)
	}
	
	method empezarJuego() {
		if (config.nivelActual() == self) {
			game.removeVisual(self)
			nivelSiguiente.ejecutar()
			config.cancionDeFondo().resume()
		}
	}
}
