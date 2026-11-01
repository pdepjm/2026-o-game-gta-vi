import wollok.game.*
import tablero.*
import mapa.*

class Municion {
    const property position = game.origin()
    const tiempoReaparicionMs = 30000 // en milisegundos (30 segundos)

    method image() = "municion.png"
    method sePuedeAtravesarPolicia() = true
    method sePuedeAtravesarLadron() = true

    // Solo se recoge si quien la toca tiene un arma que recargar
    method serRecogidaPor(policia) {
        policia.recargar()
        tablero.quitar(self)
        game.schedule(tiempoReaparicionMs, { mapa.reaparecerMunicion(self) })
    }

    method recibirImpactoDe(proyectil) {}
}