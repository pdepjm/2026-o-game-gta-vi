import wollok.game.*

//agrega y saca del tablero a los elementos que reaccionan cuando algo llega a su celda (dinero, armas, municiones, camion, balas)
//las colisiones se revisan solo cuando algo se mueve (alLlegar), no en cada cuadro del juego
object tablero {
    const reacciones = new Dictionary()

    //lo muestra y guarda como reacciona cuando algo llega a su celda: la reaccion recibe lo que llego
    method agregar(elemento, reaccion) {
        game.addVisual(elemento)
        reacciones.put(elemento, reaccion)
    }

    //lo saca y se olvida de su reaccion, para que no siga reaccionando aunque ya no este en el escenario
    method quitar(elemento) {
        game.removeVisual(elemento)
        reacciones.remove(elemento)
    }

    //se llama cuando algo termina de moverse a una celda: cada elemento que esta ahi reacciona
    method alLlegar(quienLlego) {
        game.getObjectsIn(quienLlego.position()).forEach({ elemento =>
            if (reacciones.containsKey(elemento)) { reacciones.get(elemento).apply(quienLlego) }
        })
    }
}
