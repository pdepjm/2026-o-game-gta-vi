import wollok.game.*
import direcciones.*
import tablero.*

class Personaje {
    const property posicionInicial
    var property position = posicionInicial
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
            tablero.alLlegar(self)
        }
    }

    method retroceder() { position = posicionAnterior }

    method celdaLibre(destino) = true

    method reiniciar() {
        position = posicionInicial
        posicionAnterior = position
        direccion = abajo
    }

    method image()
}