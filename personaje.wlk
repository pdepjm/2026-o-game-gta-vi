import wollok.game.*
import direcciones.*
import tablero.*
import mapa.*

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

    //no se puede pisar una celda bloqueada ni una celda con algo que este personaje no pueda atravesar
    method celdaLibre(destino) = not mapa.estaBloqueada(destino) and self.puedeAtravesarLoQueHayEn(destino)

    method puedeAtravesarLoQueHayEn(destino)

    method reiniciar() {
        position = posicionInicial
        posicionAnterior = position
        direccion = abajo
    }

    method image()
}