import wollok.game.*
import ladron.*
import policia.*
import musica.*
import pantallas.gestorPantallas.*

//configura el teclado
object controles {
    const intervaloLadron = 50
    const intervaloPolicia = 300
    var activos = false

    //los controles de personajes solo responden durante la partida
    method activar() { activos = true }
    method desactivar() { activos = false }

    method configurar() {
        keyboard.w().whilePressedDo(self.soloEnPartida({ ladron.moverseArriba() }), intervaloLadron)
        keyboard.s().whilePressedDo(self.soloEnPartida({ ladron.moverseAbajo() }), intervaloLadron)
        keyboard.a().whilePressedDo(self.soloEnPartida({ ladron.moverseIzquierda() }), intervaloLadron)
        keyboard.d().whilePressedDo(self.soloEnPartida({ ladron.moverseDerecha() }), intervaloLadron)

        keyboard.up().whilePressedDo(self.soloEnPartida({ policia.moverseArriba() }), intervaloPolicia)
        keyboard.down().whilePressedDo(self.soloEnPartida({ policia.moverseAbajo() }), intervaloPolicia)
        keyboard.left().whilePressedDo(self.soloEnPartida({ policia.moverseIzquierda() }), intervaloPolicia)
        keyboard.right().whilePressedDo(self.soloEnPartida({ policia.moverseDerecha() }), intervaloPolicia)

        keyboard.p().onPressDo(self.soloEnPartida({ policia.disparar() }))
        keyboard.enter().onPressDo({ gestorPantallas.accionarEnter() })
        keyboard.m().onPressDo({ musica.alternarPausa() })
    }

    //devuelve la misma accion pero que no hace nada si la partida no empezo
    method soloEnPartida(accion) {
        return { if (activos) accion.apply() }
    }
}
