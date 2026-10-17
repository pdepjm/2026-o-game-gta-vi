import pantallas.gameover.*
import pantallas.inicio.*
import wollok.game.*
import ladron.*
import policia.*
import municion.*
import escenario.*
import hud.*
import banco.*
import armas.*

object gestorJuego {
    var jugando = false
    var pantallaActual = null
    var itemsDeLaPartida = []

    //se llama UNA sola vez, al arrancar el programa
    method configurarJuegoBase() {
        self.crearParedes()
        self.crearMostradores()
        self.crearEscritorios()
        game.addVisual(autoPolicia)
        game.addVisual(escritorioGerenteIzquierdo)
        game.addVisual(escritorioGerenteDerecho)
        self.configurarTeclado()
        self.configurarColisiones()
        //el ladron no conoce la partida: el gestor le dice que hacer cuando se queda sin vidas
        ladron.alMorir({ self.gameover() })
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
        //las celdas que caen en la calle (filas 1 a 3) son barreras viales; el resto, paredes
        const ultimaFilaDeLaCalle = 3
        self.celdasDeParedes().forEach({ c =>
            const posicion = game.at(c.get(0) - 1, c.get(1) - 1)
            game.addVisual(if (c.get(1) <= ultimaFilaDeLaCalle) new BarreraVial(position = posicion) else new Pared(position = posicion))
        })
    }

    //celdas contadas de 1 a 20 
    method celdasDeParedes() {
        const celdas = #{}
        const celda = { x, y => celdas.add([x, y]) }
        const linea = { x1, y1, x2, y2 =>
            (x1.min(x2)..x1.max(x2)).forEach({ x =>
                (y1.min(y2)..y1.max(y2)).forEach({ y => celda.apply(x, y) })
            })
        }

        linea.apply(1, 1, 1, 20)
        linea.apply(1, 20, 20, 20)
        linea.apply(20, 20, 20, 1)
        linea.apply(5, 4, 17, 4)
        linea.apply(6, 4, 6, 16)
        linea.apply(13, 5, 13, 9)
        linea.apply(16, 7, 16, 16)
        linea.apply(17, 7, 19, 7)

        //fila 0 cierra el borde de abajo para que nadie salga del mapa
        linea.apply(1, 0, 20, 0)

        celda.apply(19, 4)
        celda.apply(16, 19)
        celda.apply(11, 9)
        celda.apply(7, 9)
        celda.apply(8, 9)
        celda.apply(4, 4)
        celda.apply(12, 9)

        return celdas
    }

    //mostradores en la columna 4: cada uno ocupa dos celdas (filas 6-7, 9-10, 12-13 y 15-16, contadas de 1 a 20)
    method crearMostradores() {
        [6, 9, 12, 15].forEach({ filaDeAbajo =>
            game.addVisual(new MostradorAbajo(position = game.at(3, filaDeAbajo - 1)))
            game.addVisual(new MostradorArriba(position = game.at(3, filaDeAbajo)))
        })
    }

    //escritorios verticales en la columna 8: cada uno ocupa dos celdas (filas 11-12 y 14-15, contadas de 1 a 20)
    method crearEscritorios() {
        [11, 14].forEach({ filaDeAbajo =>
            game.addVisual(new EscritorioVerticalAbajo(position = game.at(7, filaDeAbajo - 1)))
            game.addVisual(new EscritorioVerticalArriba(position = game.at(7, filaDeAbajo)))
        })
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
        game.onCollideDo(camionAtras, { personaje => personaje.chocarConCamion(camion) })
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
        pantallaActual.ocultar()
        pantallaActual = null
        jugando = true
        itemsDeLaPartida = []
        game.removeVisual(puntajeFinal)
        banco.reponer()
        self.agregarArmas()
        self.agregarMuniciones()
        self.agregarPersonajes()
        self.agregarHud()
    }

    method gameover() {
        jugando = false
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
        puntaje.reiniciar()
    }
}