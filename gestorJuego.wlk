import pantallas.gameover.*
import pantallas.inicio.*
import pantallas.gestorPantallas.*
import wollok.game.*
import ladron.*
import policia.*
import municion.*
import escenario.*
import hud.*
import banco.*
import armas.*
import mapa.*
import controles.*
import colisiones.*

//maneja el flujo de la partida
object gestorJuego {
    var itemsDeLaPartida = []

    //se llama UNA sola vez, al arrancar el programa
    method configurarJuegoBase() {
        mapa.armar()
        controles.configurar()
        colisiones.configurar()
        //el ladron no conoce la partida: el gestor le dice que hacer cuando se queda sin vidas
        ladron.alMorir({ self.gameover() })
    }

    method agregarArmas() {
        const agregar = { arma =>
            game.addVisual(arma)
            game.onCollideDo(arma, { personaje => personaje.chocarConArma(arma) })
            itemsDeLaPartida.add(arma)
        }
        agregar.apply(new Pistola(position = game.at(17, 0)))
        agregar.apply(new Escopeta(position = game.at(16, 0)))
    }

    method agregarMuniciones() {
        const agregar = { municion =>
            game.addVisual(municion)
            game.onCollideDo(municion, { personaje => personaje.chocarConMunicion(municion) })
            itemsDeLaPartida.add(municion)
        }
        agregar.apply(new Municion(position = game.at(15, 0)))
        agregar.apply(new Municion(position = game.at(14, 0)))
    }

    //se agrega despues de las paredes, asi se dibuja encima de la pared de arriba
    method agregarHud() {
        game.addVisual(puntaje)
        game.addVisual(vidas)
    }

    method agregarPersonajes() {
        game.addVisual(camion)
        game.addVisual(camionAtras)
        game.addVisual(policia)
        game.addVisual(ladron)
    }

    //se llama al apretar ENTER desde pantallaReglas
    method comenzarJuego() {
        gestorPantallas.ocultarActual()
        controles.activar()
        itemsDeLaPartida = []
        game.removeVisual(puntajeFinal)
        banco.reponer()
        self.agregarArmas()
        self.agregarMuniciones()
        self.agregarPersonajes()
        self.agregarHud()
    }

    method gameover() {
        controles.desactivar()
        game.removeVisual(ladron)
        game.removeVisual(policia)
        game.removeVisual(camion)
        game.removeVisual(camionAtras)
        game.removeVisual(puntaje)
        game.removeVisual(vidas)
        banco.vaciar()
        //ademas de sacar el item del escenario hay que dar de baja su handler de colision
        itemsDeLaPartida.forEach({ item =>
            game.removeVisual(item)
            io.removeCollitionHandler(item.identity())
        })
        itemsDeLaPartida = []
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