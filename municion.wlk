import wollok.game.*
import direcciones.*

class Proyectil{
  var property position
  const direccion
  const property danioProyectil
  var activo = true              //activo parece redundante pero evita procesar el mismo impacto dos veces: si dos cosas coinciden en la celda del                   
  const intervaloMovimiento = 150 //proyectil en el mismo instante, o si avanzar() ya estaba programado cuando esto se destruye

  method image() = "proyectil.png"

  //el proyectil se registra a si mismo para recibir colisiones y se mueve solo hasta que impacta con algo
  method iniciarMovimiento(){
    game.onCollideDo(self, { objetoChocado => self.impactar(objetoChocado) })
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
      game.removeVisual(self)
      io.removeCollitionHandler(self.identity()) // para que no siga recibiendo colisiones aunque ya no este en el escenario
    }
  }

  //dos balas pueden coincidir en la misma celda (mas aun si el juego viene lento) se cruzan sin afectarse,
  
  method recibirImpactoDe(proyectil){}

  method chocarConDinero(dinero){}
  method chocarConCamion(camion){}
  method chocarConMunicion(municion){}
  method chocarConArma(arma){}

  //un proyectil no bloquea el paso de nadie
  method sePuedeAtravesarLadron() = true
  method sePuedeAtravesarPolicia() = true
}

object municion {
  const property position = game.at(14, 10)

  method image() = "municion2.jpg"
  method sePuedeAtravesarPolicia() = true
  method sePuedeAtravesarLadron() = true

  //solo se recoge si quien la toca tiene un arma que recargar
  method serRecogidaPor(policia){
    policia.recargar()
    game.removeVisual(self)
  }

}