import pantallas.gameover.*
import pantallas.inicio.*
import wollok.game.*
import personaje.*
import ladron.*
import policia.*
import municion.*
import escenario.*
import dinero.*
import direcciones.*
import armas.*
import pantallas.pantalla.*

object gestorJuego {
    var jugando = false
    var pantallaActual = null
    var itemsDeLaPartida = []

    method jugando() = jugando

    //se llama UNA sola vez, al arrancar el programa
    method configurarJuegoBase() {
        self.crearParedes()
        self.configurarTeclado()
        self.configurarColisiones()
        keyboard.enter().onPressDo({ self.accionarEnterActual() })
    }

    // Controla el presionar enter y el cambio de pantallas
    method accionarEnterActual() {
        if (pantallaActual != null) { pantallaActual.accionarEnter() }
    }

    method mostrarPantalla(pantalla) {
        if (pantallaActual != null) { pantallaActual.ocultar() }
        pantallaActual = pantalla
        pantalla.mostrar()
    }

    method crearParedes() {
        const filaDeArriba = (-1..game.width()).map({i => new Pared(position = game.at(i, game.height()))})
        const filaDeAbajo = (-1..game.width()).map({i => new Pared(position = game.at(i, -1))})
        const columnaIzquierda = (0..(game.height() - 1)).map({j => new Pared(position = game.at(-1, j))})
        const columnaDerecha = (0..(game.height() - 1)).map({j => new Pared(position = game.at(game.width(), j))})
        filaDeArriba.forEach({ pared => game.addVisual(pared) })
        filaDeAbajo.forEach({ pared => game.addVisual(pared) })
        columnaIzquierda.forEach({ pared => game.addVisual(pared) })
        columnaDerecha.forEach({ pared => game.addVisual(pared) })
    }

    method configurarTeclado() {
        keyboard.w().whilePressedDo({ if (jugando) ladron.moverseArriba() }, 50)
        keyboard.s().whilePressedDo({ if (jugando) ladron.moverseAbajo() }, 50)
        keyboard.a().whilePressedDo({ if (jugando) ladron.moverseIzquierda() }, 50)
        keyboard.d().whilePressedDo({ if (jugando) ladron.moverseDerecha() }, 50)

        keyboard.up().whilePressedDo({ if (jugando) policia.moverseArriba() }, 300)
        keyboard.down().whilePressedDo({ if (jugando) policia.moverseAbajo() }, 300)
        keyboard.left().whilePressedDo({ if (jugando) policia.moverseIzquierda() }, 300)
        keyboard.right().whilePressedDo({ if (jugando) policia.moverseDerecha() }, 300)

        keyboard.p().onPressDo({ if (jugando) policia.disparar() })
    }

    method configurarColisiones() {
        game.onCollideDo(camion, { personaje => personaje.chocarConCamion(camion) })
    }

    method agregarDinero() {
        const agregar = { dinero =>
            game.addVisual(dinero)
            game.onCollideDo(dinero, { personaje => personaje.chocarConDinero(dinero) })
            itemsDeLaPartida.add(dinero)
        }
        agregar.apply(new Moneda(position = game.at(5, 5)))
        agregar.apply(new Moneda(position = game.at(7, 5)))
        agregar.apply(new BolsaDeDinero(position = game.at(9, 5)))
        agregar.apply(new Diamante(position = game.at(11, 5)))
    }

    method agregarArmas() {
        const agregar = { arma =>
            game.addVisual(arma)
            game.onCollideDo(arma, { personaje => personaje.chocarConArma(arma) })
            itemsDeLaPartida.add(arma)
        }
        agregar.apply(new Pistola(position = game.at(16, 11)))
        agregar.apply(new Escopeta(position = game.at(16, 10)))

        //la municion se registra en cada partida (no una sola vez) porque gameover() da de baja el handler de todos los items
        game.addVisual(municion)
        game.onCollideDo(municion, { personaje => personaje.chocarConMunicion(municion) })
        itemsDeLaPartida.add(municion)
    }

    method agregarPersonajes() {
        game.addVisual(camion)
        game.addVisual(policia)
        game.addVisual(ladron)
        game.addVisual(puntaje)
        game.addVisual(vidas)
    }

    //se llama al apretar ENTER desde pantallaReglas
    method comenzarJuego() {
        pantallaActual.ocultar()
        pantallaActual = null
        jugando = true
        itemsDeLaPartida = []
        game.removeVisual(puntajeFinal)
        self.agregarDinero()
        self.agregarArmas()
        self.agregarPersonajes()
    }

    method gameover() {
        jugando = false
        game.removeVisual(ladron)
        game.removeVisual(policia)
        game.removeVisual(camion)
        game.removeVisual(puntaje)
        game.removeVisual(vidas)
        //ademas de sacar el item del escenario hay que dar de baja su handler de colision
        itemsDeLaPartida.forEach({ item =>
            game.removeVisual(item)
            io.removeCollitionHandler(item.identity())
        })
        itemsDeLaPartida = []
        self.mostrarPantalla(pantallaGameOver)
        game.addVisual(puntajeFinal)
    }

    //se llama al apretar ENTER desde pantallaGameOver
    method volverAlInicio() {
        self.reiniciarEstado()
        self.mostrarPantalla(pantallaInicio)
    }

    method reiniciarEstado() {
        ladron.reiniciar()
        policia.reiniciar()
        vidas.reiniciar()
        puntaje.reiniciar()
    }
}