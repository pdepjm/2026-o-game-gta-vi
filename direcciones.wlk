import wollok.game.*

object arriba {
  method siguientePosicion(posicion) = posicion.up(1)
}

object abajo {
  method siguientePosicion(posicion) = posicion.down(1)
}

object izquierda {
  method siguientePosicion(posicion) = posicion.left(1)
}

object derecha {
  method siguientePosicion(posicion) = posicion.right(1)
}
