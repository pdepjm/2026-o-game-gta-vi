import wollok.game.*

//un efecto de sonido que puede sonar muchas veces
//un sonido en Wollok Game se reproduce una vez, asi que hay dos que se turnan. al sonar uno se corta el anterior
//que ya termino, y asi esta fuera de la lista del juego el tiempo suficiente para volver a sonar
class EfectoDeSonido {
    const archivo
    const sonidos = [game.sound(archivo), game.sound(archivo)]
    var turno = 0

    method sonar() {
        const anterior = sonidos.get(1 - turno)
        if (anterior.played()) { anterior.stop() }
        sonidos.get(turno).play()
        turno = 1 - turno
    }
}

//cada arma suena distinto al disparar
object sonidoPistola inherits EfectoDeSonido(archivo = "sonidoPistola.mp3") {}

object sonidoEscopeta inherits EfectoDeSonido(archivo = "sonidoEscopeta.mp3") {}

//cada tipo de dinero suena distinto al levantarlo
object sonidoMoneda inherits EfectoDeSonido(archivo = "sonidoMoneda.mp3") {}

object sonidoBolsa inherits EfectoDeSonido(archivo = "sonidoBolsa.mp3") {}

object sonidoDiamante inherits EfectoDeSonido(archivo = "sonidoDiamante.mp3") {}

//entregar la carga al camion suena igual para todo lo que se entregue
object sonidoEntrega inherits EfectoDeSonido(archivo = "sonidoEntrega.mp3") {}

//equipar un arma suena igual para todas las armas
object sonidoEquiparArma inherits EfectoDeSonido(archivo = "sonidoEquiparArma.mp3") {}

//el arma se recarga al recoger municion
object sonidoRecargar inherits EfectoDeSonido(archivo = "sonidoRecargar.mp3") {}

//intentar disparar sin balas en el cargador
object sonidoCargadorVacio inherits EfectoDeSonido(archivo = "sonidoCargadorVacio.mp3") {}

//una bala que impacta con el ladron
object sonidoImpactoBala inherits EfectoDeSonido(archivo = "sonidoImpactoBala.mp3") {}

//el ladron se queda sin vidas
object sonidoMuerteLadron inherits EfectoDeSonido(archivo = "sonidoMuerteLadron.mp3") {}
