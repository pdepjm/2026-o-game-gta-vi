import wollok.game.*

object arriba {
  method siguientePosicion(posicion) = posicion.up(1)
  method imagenPolicia() = "policiaArriba.png"
  method imagenLadron() = "ladron2.png"
}

object abajo {
  method siguientePosicion(posicion) = posicion.down(1)
  method imagenPolicia() = "policiaAbajo.png"
  method imagenLadron() = "ladron2.png"
}

//no hay assets del policia de costado por ahora
object izquierda {
  method siguientePosicion(posicion) = posicion.left(1)
  method imagenPolicia() = "policiaAbajo.png"
  method imagenLadron() = "ladron2.png"
}

object derecha {
  method siguientePosicion(posicion) = posicion.right(1)
  method imagenPolicia() = "policiaAbajo.png"
  method imagenLadron() = "ladron2.png"
}
