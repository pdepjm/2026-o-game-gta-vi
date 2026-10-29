import wollok.game.*
import tablero.*

class Proyectil{
  var position
  const direccion
  const property danioProyectil
  //activo parece redundante pero evita procesar el mismo impacto dos veces: si dos cosas coinciden en la celda del
  //proyectil en el mismo instante, o si avanzar() ya estaba programado cuando el proyectil se destruye
  var activo = true
  const intervaloMovimiento = 150

  method position() = position

  method image() = direccion.imagenBala()

  //el proyectil se agrega al tablero (asi lo que se mueva hasta su celda lo choca) y se mueve solo hasta que impacta con algo
  method iniciarMovimiento(){
    tablero.agregar(self, { objetoChocado => self.impactar(objetoChocado) })
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

  //choca con todo lo que hay en su celda: se revisa solo al aparecer y al avanzar, no en cada cuadro
  method chocarEnSuCelda(){
    game.getObjectsIn(position).forEach({ objeto => self.impactar(objeto) })
  }

  method siguientePosicion() = direccion.siguientePosicion(position)

  //cada objeto que puede ser tocado por un proyectil decide que le pasa en su propio recibirImpactoDe
  method impactar(objetoChocado){
    if (activo) { objetoChocado.recibirImpactoDe(self) }
  }

  method destruir(){
    if (activo) {
      activo = false
      tablero.quitar(self)
    }
  }

  //dos balas pueden coincidir en la misma celda (mas aun si el juego viene lento): se cruzan sin afectarse
  method recibirImpactoDe(proyectil){}

  //un proyectil no bloquea el paso de nadie
  method sePuedeAtravesarLadron() = true
  method sePuedeAtravesarPolicia() = true
}
