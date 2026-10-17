import wollok.game.*
import dinero.*

object banco {
    const dineroEnMapa = []

    const celdasDeMonedas = [[19, 17], [19, 18], [19, 19], [7, 8], [8, 8], [9, 12], [9, 15], [5, 6], [5, 9], [5, 12]]
    const celdasDeBolsas = [[5, 15], [7, 11], [7, 14], [19, 5], [19, 6], [19, 12], [12, 6], [12, 7], [12, 5], [12, 8], [19, 13], [19, 14], [19, 15]]
    const celdasDeDiamantes = [[17, 8], [18, 8], [19, 8], [9, 5], [17, 9], [18, 9], [19, 9]]

    //crea dinero NUEVO en las celdas del banco: se usa al empezar la partida y cada vez que el mapa se queda sin dinero
    method reponer() {
        self.reponerEn(celdasDeMonedas, { posicion => new Moneda(position = posicion) })
        self.reponerEn(celdasDeBolsas, { posicion => new BolsaDeDinero(position = posicion) })
        self.reponerEn(celdasDeDiamantes, { posicion => new Diamante(position = posicion) })
    }

    method reponerEn(celdas, nuevoDinero) {
        celdas.forEach({ c => self.agregar(nuevoDinero.apply(game.at(c.get(0) - 1, c.get(1) - 1))) })
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