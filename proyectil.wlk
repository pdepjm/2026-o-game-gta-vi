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

  //el proyectil se agrega al tablero para recibir colisiones y se mueve solo hasta que impacta con algo
  method iniciarMovimiento(){
    tablero.agregar(self, { objetoChocado => self.impactar(objetoChocado) })
    self.programarSiguienteMovimiento()
  }

  method programarSiguienteMovimiento(){
    game.schedule(intervaloMovimiento, { self.avanzar() })
  }

  //recursividad para que el proyectil siga avanzando hasta que impacte con algo
  method avanzar(){
    if (activo) {
      position = self.siguientePosicion()
      self.programarSiguienteMovimiento()
    }
  }

  method siguientePosicion() = direccion.siguientePosicion(position)

  //cada objeto que puede ser tocado por un proyectil decide que le pasa en su propio recibirImpactoDe
  method impactar(objetoChocado){
    if (activo) { objetoChocado.recibirImpactoDe(self) }
  }

  //ademas de sacarlo del tablero, hay que dar de baja el handler de colision
  method destruir(){
    if (activo) {
      activo = false
      tablero.quitar(self)
    }
  }

  //dos balas pueden coincidir en la misma celda (mas aun si el juego viene lento): se cruzan sin afectarse
  method recibirImpactoDe(proyectil){}

  method chocarConDinero(dinero){}
  method chocarConCamion(camion){}
  method chocarConMunicion(municion){}
  method chocarConArma(arma){}

  //un proyectil no bloquea el paso de nadie
  method sePuedeAtravesarLadron() = true
  method sePuedeAtravesarPolicia() = true
}
