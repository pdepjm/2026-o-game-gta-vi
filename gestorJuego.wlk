import pantallas.gameover.*
import pantallas.inicio.*
import pantallas.gestorPantallas.*
import wollok.game.*
import ladron.*
import policia.*
import hud.*
import banco.*
import mapa.*
import controles.*
import colisiones.*

//maneja el flujo de la partida
object gestorJuego {
    //se llama UNA sola vez, al arrancar el programa
    method configurarJuegoBase() {
        mapa.armar()
        controles.configurar()
        colisiones.configurar()
        //el ladron no conoce la partida: el gestor le dice que hacer cuando se queda sin vidas
        ladron.alMorir({ self.gameover() })
    }

    //se llama al apretar ENTER desde pantallaReglas
    method comenzarJuego() {
        gestorPantallas.ocultarActual()
        controles.activar()
        game.removeVisual(puntajeFinal)
        banco.reponer()
        mapa.mostrar()
        hud.mostrar()
    }

    method gameover() {
        controles.desactivar()
        mapa.ocultar()
        hud.ocultar()
        banco.vaciar()
        gestorPantallas.mostrar(pantallaGameOver)
        game.addVisual(puntajeFinal)
    }

    //se llama al apretar ENTER desde pantallaGameOver
    method volverAlInicio() {
        self.reiniciarEstado()
        gestorPantallas.mostrar(pantallaInicio)
    }

    method reiniciarEstado() {
        ladron.reiniciar()
        policia.reiniciar()
        puntaje.reiniciar()
    }
}