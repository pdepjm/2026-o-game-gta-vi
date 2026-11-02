import wollok.game.*

//las colisiones se revisan solo cuando algo se mueve, no en cada cuadro del juego
object tablero {
    //se llama cuando algo termina de moverse a una celda: cada elemento que esta ahi reacciona a esa llegada
    method alLlegar(quienLlego) {
        game.getObjectsIn(quienLlego.position()).forEach({ elemento => elemento.reaccionarAlLlegar(quienLlego) })
    }
}
