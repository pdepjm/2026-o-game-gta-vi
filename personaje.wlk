import direcciones.*
import tablero.*
import celdasBloqueadas.*
import elementoDelTablero.*

class Personaje inherits ElementoDelTablero {
    const property posicionInicial
    var property position = posicionInicial
    var property direccion = abajo
    var posicionAnterior = position

    method moverHacia(nuevaDireccion) {
        direccion = nuevaDireccion
        self.moverA(direccion.siguientePosicion(position))
    }

    method moverA(destino) {
        if (self.puedeMoverse() and self.celdaLibre(destino)) {
            posicionAnterior = position
            position = destino
            self.alMoverse()
            tablero.alLlegar(self)
        }
    }

    //un personaje puede moverse siempre, salvo que tenga que esperar entre paso y paso y la redefina
    method puedeMoverse() = true

    //se llama justo despues de moverse: lo redefine el personaje que necesita anotarlo
    method alMoverse() {}

    method retroceder() { position = posicionAnterior }

    //no se puede pisar una celda bloqueada ni una celda con algo que este personaje no pueda atravesar
    method celdaLibre(destino) = not celdasBloqueadas.incluye(destino) and self.puedeAtravesarLoQueHayEn(destino)

    method puedeAtravesarLoQueHayEn(destino)

    method reiniciar() {
        position = posicionInicial
        posicionAnterior = position
        direccion = abajo
    }

    method image()
}