import wollok.game.*
import ladron.*
import policia.*
import pantallas.gestorPantallas.*
import musica.*

//configura el teclado
object controles {
    const intervaloLadron = 50
    const intervaloPolicia = 300
    var activos = false

    //los controles de personajes solo responden durante la partida
    method activar() { activos = true }
    method desactivar() { activos = false }

    method configurar() {
        keyboard.w().whilePressedDo({ if (activos) ladron.moverseArriba() }, intervaloLadron)
        keyboard.s().whilePressedDo({ if (activos) ladron.moverseAbajo() }, intervaloLadron)
        keyboard.a().whilePressedDo({ if (activos) ladron.moverseIzquierda() }, intervaloLadron)
        keyboard.d().whilePressedDo({ if (activos) ladron.moverseDerecha() }, intervaloLadron)

        keyboard.up().whilePressedDo({ if (activos) policia.moverseArriba() }, intervaloPolicia)
        keyboard.down().whilePressedDo({ if (activos) policia.moverseAbajo() }, intervaloPolicia)
        keyboard.left().whilePressedDo({ if (activos) policia.moverseIzquierda() }, intervaloPolicia)
        keyboard.right().whilePressedDo({ if (activos) policia.moverseDerecha() }, intervaloPolicia)

        keyboard.p().onPressDo({ if (activos) policia.disparar() })
        keyboard.enter().onPressDo({ gestorPantallas.accionarEnter() })
        keyboard.m().onPressDo({ musica.alternarPausa() })
    }
}
