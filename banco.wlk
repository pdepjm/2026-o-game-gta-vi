import wollok.game.*
import dinero.*
import efectos.*

object banco {
    const dineroEnMapa = []

    //las celdas se cuentan de 0 a 19
    method celdasDeMonedas() = [
        game.at(18, 16), game.at(18, 17), game.at(18, 18), game.at(6, 7),
        game.at(7, 7), game.at(8, 11), game.at(8, 14), game.at(4, 5),
        game.at(4, 8), game.at(4, 11)
    ]

    method celdasDeBolsas() = [
        game.at(4, 14), game.at(6, 10), game.at(6, 13), game.at(18, 4),
        game.at(18, 5), game.at(18, 11), game.at(11, 5), game.at(11, 6),
        game.at(11, 4), game.at(11, 7), game.at(18, 12), game.at(18, 13),
        game.at(18, 14)
    ]

    method celdasDeDiamantes() = [
        game.at(16, 7), game.at(17, 7), game.at(18, 7), game.at(8, 4),
        game.at(16, 8), game.at(17, 8), game.at(18, 8)
    ]

    //crea dinero NUEVO en las celdas del banco: se usa al empezar la partida y cada vez que el mapa se queda sin dinero
    method reponer() {
        self.reponerEn(self.celdasDeMonedas(), { posicion => self.moneda(posicion) })
        self.reponerEn(self.celdasDeBolsas(), { posicion => self.bolsa(posicion) })
        self.reponerEn(self.celdasDeDiamantes(), { posicion => self.diamante(posicion) })
    }

    method moneda(posicion) = new Dinero(position = posicion, valor = 10, imagen = "moneda.png", modificadorVelocidad = 0, nombre = "Moneda", sonido = sonidoMoneda)

    method bolsa(posicion) = new Dinero(position = posicion, valor = 100, imagen = "bolsa.png", modificadorVelocidad = -100, nombre = "Bolsa de dinero", sonido = sonidoBolsa)

    method diamante(posicion) = new Dinero(position = posicion, valor = 500, imagen = "diamante.png", modificadorVelocidad = 100, nombre = "Diamante", sonido = sonidoDiamante)

    method reponerEn(posiciones, nuevoDinero) {
        posiciones.forEach({ posicion => self.agregar(nuevoDinero.apply(posicion)) })
    }

    //ademas de mostrarlo, el dinero se registra para detectar cuando lo toca un personaje
    method agregar(dinero) {
        dineroEnMapa.add(dinero)
        game.addVisual(dinero)
    }

    method retirar(dinero) {
        dineroEnMapa.remove(dinero)
        game.removeVisual(dinero)
    }

    //saca todo el dinero que quede en el mapa (al terminar una partida)
    method vaciar() {
        dineroEnMapa.copy().forEach({ dinero => self.retirar(dinero) })
    }

    method sinDinero() = dineroEnMapa.isEmpty()

    //el banco es quien conoce la regla de reposicion: el camion solo le avisa que hubo una entrega
    method entregaRealizada() {
        if (self.sinDinero()) { self.reponer() }
    }
}