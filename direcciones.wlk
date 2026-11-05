object arriba {
  method siguientePosicion(posicion) = posicion.up(1)
  method imagenPolicia() = "policiaArriba.png"
  method imagenLadron() = "ladronArriba.png"
  method imagenBala() = "balaArriba.png"
}

object abajo {
  method siguientePosicion(posicion) = posicion.down(1)
  method imagenPolicia() = "policiaAbajo.png"
  method imagenLadron() = "ladronAbajo.png"
  method imagenBala() = "balaAbajo.png"
}

object izquierda {
  method siguientePosicion(posicion) = posicion.left(1)
  method imagenPolicia() = "policiaIzquierda.png"
  method imagenLadron() = "ladronIzquierda.png"
  method imagenBala() = "balaIzquierda.png"
}

object derecha {
  method siguientePosicion(posicion) = posicion.right(1)
  method imagenPolicia() = "policiaDerecha.png"
  method imagenLadron() = "ladronDerecha.png"
  method imagenBala() = "balaDerecha.png"
}
