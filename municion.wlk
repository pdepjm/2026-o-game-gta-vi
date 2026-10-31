import wollok.game.*
import tablero.*

class Municion {
    const property position = game.origin()
    const tiempoReaparicionMs = 30000 // Tiempo en milisegundos (5 segundos)

    method image() = "municion.png"
    method sePuedeAtravesarPolicia() = true
    method sePuedeAtravesarLadron() = true

    // Solo se recoge si quien la toca tiene un arma que recargar
    method serRecogidaPor(policia) {
        policia.recargar()
        tablero.quitar(self)
        game.schedule(tiempoReaparicionMs, { self.reaparecer() })
    }

    method reaparecer() {
        tablero.agregar(self, { policia => policia.chocarConMunicion(self) })
    }

    method recibirImpactoDe(proyectil) {}
}