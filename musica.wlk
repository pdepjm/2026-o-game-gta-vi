import wollok.game.*

//musica de fondo del juego
object musica {
    const sonido = game.sound("musicaDeFondo.mp3")

    //se llama UNA sola vez, al arrancar el programa suena en bucle hasta que se pausa
    method iniciar() {
        sonido.shouldLoop(true)
        sonido.volume(0.4)
        sonido.play()
    }

    //si esta pausada la reanuda y si esta sonando la pausa
    method alternarPausa() {
        if (sonido.paused()) { sonido.resume() } else { sonido.pause() }
    }
}
