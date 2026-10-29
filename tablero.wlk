import wollok.game.*

//agrega y saca del tablero a los elementos que reaccionan cuando algo choca con ellos (dinero, armas, municiones, balas)
object tablero {

    //lo muestra y registra como reacciona cuando algo choca con el: la reaccion recibe lo que choco
    method agregar(elemento, reaccion) {
        game.addVisual(elemento)
        game.onCollideDo(elemento, reaccion)
    }

    //lo saca y da de baja su handler de colision, para que no siga recibiendo colisiones aunque ya no este en el escenario
    method quitar(elemento) {
        game.removeVisual(elemento)
        io.removeCollitionHandler(elemento.identity())
    }
}
