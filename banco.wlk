import wollok.game.*
import dinero.*

object banco {
    const dineroEnMapa = []

    //las celdas se cuentan de 1 a 20 (como en pantalla): se resta 1 para el juego
    method celda(x, y) = game.at(x - 1, y - 1)

    method celdasDeMonedas() = [
        self.celda(19, 17), self.celda(19, 18), self.celda(19, 19), self.celda(7, 8),
        self.celda(8, 8), self.celda(9, 12), self.celda(9, 15), self.celda(5, 6),
        self.celda(5, 9), self.celda(5, 12)
    ]

    method celdasDeBolsas() = [
        self.celda(5, 15), self.celda(7, 11), self.celda(7, 14), self.celda(19, 5),
        self.celda(19, 6), self.celda(19, 12), self.celda(12, 6), self.celda(12, 7),
        self.celda(12, 5), self.celda(12, 8), self.celda(19, 13), self.celda(19, 14),
        self.celda(19, 15)
    ]

    method celdasDeDiamantes() = [
        self.celda(17, 8), self.celda(18, 8), self.celda(19, 8), self.celda(9, 5),
        self.celda(17, 9), self.celda(18, 9), self.celda(19, 9)
    ]

    //crea dinero NUEVO en las celdas del banco: se usa al empezar la partida y cada vez que el mapa se queda sin dinero
    method reponer() {
        self.reponerEn(self.celdasDeMonedas(), { posicion => self.moneda(posicion) })
        self.reponerEn(self.celdasDeBolsas(), { posicion => self.bolsa(posicion) })
        self.reponerEn(self.celdasDeDiamantes(), { posicion => self.diamante(posicion) })
    }

    method moneda(posicion) = new Dinero(position = posicion, valor = 10, imagen = "moneda.png", modificadorVelocidad = 0, nombre = "Moneda")

    method bolsa(posicion) = new Dinero(position = posicion, valor = 100, imagen = "bolsa.png", modificadorVelocidad = -100, nombre = "Bolsa de dinero")

    method diamante(posicion) = new Dinero(position = posicion, valor = 500, imagen = "diamante.png", modificadorVelocidad = 100, nombre = "Diamante")

    method reponerEn(posiciones, nuevoDinero) {
        posiciones.forEach({ posicion => self.agregar(nuevoDinero.apply(posicion)) })
    }

    //ademas de mostrarlo, el dinero se registra para detectar cuando lo toca un personaje
    method agregar(dinero) {
        dineroEnMapa.add(dinero)
        game.addVisual(dinero)
        game.onCollideDo(dinero, { personaje => personaje.chocarConDinero(dinero) })
    }

    //ademas de sacarlo del escenario hay que dar de baja su handler de colision
    method retirar(dinero) {
        dineroEnMapa.remove(dinero)
        game.removeVisual(dinero)
        io.removeCollitionHandler(dinero.identity())
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