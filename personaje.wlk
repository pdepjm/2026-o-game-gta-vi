import wollok.game.*
import direcciones.*

class Personaje {
    var property position
    var property direccion = abajo
    var posicionAnterior = position

    method moverseArriba()    { self.moverHacia(arriba) }
    method moverseAbajo()     { self.moverHacia(abajo) }
    method moverseIzquierda() { self.moverHacia(izquierda) }
    method moverseDerecha()   { self.moverHacia(derecha) }

    method moverHacia(nuevaDireccion) {
        direccion = nuevaDireccion
        self.moverA(direccion.siguientePosicion(position))
    }

    method moverA(destino) {
        if (self.celdaLibre(destino)) {
            posicionAnterior = position
            position = destino
        }
    }

    method retroceder() { position = posicionAnterior }

    method celdaLibre(destino) = true

    method reiniciar() {
        position = self.posicionInicial()
        posicionAnterior = position
        direccion = abajo
    }

    method posicionInicial()

    method image()
}