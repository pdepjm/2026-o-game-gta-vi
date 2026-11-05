import wollok.game.*
import celdasBloqueadas.*
import elementoDelTablero.*

class Proyectil inherits ElementoDelTablero {
  var position
  const direccion
  const property danioProyectil
  //activo parece redundante pero evita procesar el mismo impacto dos veces: si dos cosas coinciden en la celda del
  //proyectil en el mismo instante, o si avanzar() ya estaba programado cuando el proyectil se destruye
  var activo = true
  const intervaloMovimiento = 150

  method position() = position

  method image() = direccion.imagenBala()

  //el proyectil se muestra en el tablero y se mueve solo hasta que impacta con algo
  method iniciarMovimiento(){
    game.addVisual(self)
    self.chocarEnSuCelda()
    self.programarSiguienteMovimiento()
  }

  method programarSiguienteMovimiento(){
    game.schedule(intervaloMovimiento, { self.avanzar() })
  }

  //recursividad para que el proyectil siga avanzando hasta que impacte con algo
  method avanzar(){
    if (activo) {
      position = self.siguientePosicion()
      self.chocarEnSuCelda()
      self.programarSiguienteMovimiento()
    }
  }

  //si su celda esta bloqueada se destruye y si no choca con todo lo que hay ahi. se revisa solo al aparecer y al avanzar, no en cada cuadro
  method chocarEnSuCelda(){
    if (celdasBloqueadas.incluye(position)) { self.destruir() }
    else { game.getObjectsIn(position).forEach({ objeto => self.impactar(objeto) }) }
  }

  method siguientePosicion() = direccion.siguientePosicion(position)

  //cada objeto que puede ser tocado por un proyectil decide que le pasa en su propio recibirImpactoDe
  method impactar(objetoChocado){
    if (activo) { objetoChocado.recibirImpactoDe(self) }
  }

  method destruir(){
    if (activo) {
      activo = false
      game.removeVisual(self)
    }
  }

  //lo que se mueva hasta la celda del proyectil lo choca
  override method reaccionarAlLlegar(quienLlego){ self.impactar(quienLlego) }

  //dos balas pueden coincidir en la misma celda (mas aun si el juego viene lento): se cruzan sin afectarse
  //como todo ElementoDelTablero, el proyectil no hace nada al recibir un impacto y no bloquea el paso de nadie
}
