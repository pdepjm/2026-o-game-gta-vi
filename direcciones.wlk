import wollok.game.*

object arriba {
  method siguientePosicion(posicion) = posicion.up(1)
  method imagenPolicia() = "policiaArriba.png"
  method imagenLadron() = "ladronArriba.png"
}

object abajo {
  method siguientePosicion(posicion) = posicion.down(1)
  method imagenPolicia() = "policiaAbajo.png"
  method imagenLadron() = "ladronAbajo.png"
}

object izquierda {
  method siguientePosicion(posicion) = posicion.left(1)
  method imagenPolicia() = "policiaIzquierda.png"
  method imagenLadron() = "ladronIzquierda.png"
}

object derecha {
  method siguientePosicion(posicion) = posicion.right(1)
  method imagenPolicia() = "policiaDerecha.png"
  method imagenLadron() = "ladronDerecha.png"
}
