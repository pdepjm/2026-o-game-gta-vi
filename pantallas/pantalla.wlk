import wollok.game.*

class Pantalla {
    method position() = game.origin()

    method mostrar() { game.addVisual(self) }
    method ocultar() { game.removeVisual(self) }

    method accionarEnter()
    method image()
}

object sinPantalla {
    method ocultar() {}

    method accionarEnter() {}
}