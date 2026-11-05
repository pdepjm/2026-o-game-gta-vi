import wollok.game.*
import mapa.*
import elementoDelTablero.*

class Municion inherits ElementoDelTablero {
    const property position = game.origin()

    method image() = "municion.png"

    override method reaccionarAlLlegar(quienLlego){ quienLlego.chocarConMunicion(self) }

    // Solo la recoge el policia, y recarga el arma que tenga equipada (si no tiene, la deja en el mapa)
    method serRecogidaPor(policia) {
        policia.recargar()
        game.removeVisual(self)
        mapa.itemTomado(self)
    }

    //la municion que se recogio vuelve a aparecer es la misma
    method elQueReaparece() = self
}
