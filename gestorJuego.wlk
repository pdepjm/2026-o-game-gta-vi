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
        self.crearMostradores()
        self.crearEscritorios()
        game.addVisual(autoPolicia)
        game.addVisual(escritorioGerenteIzquierdo)
        game.addVisual(escritorioGerenteDerecho)
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
        // se guardan en un set para que las esquina
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

        //las celdas que caen en la calle (filas 1 a 3) son barreras viales; el resto, paredes
        const ultimaFilaDeLaCalle = 3
        celdas.forEach({ c =>
            const posicion = game.at(c.get(0) - 1, c.get(1) - 1)
            game.addVisual(if (c.get(1) <= ultimaFilaDeLaCalle) new BarreraVial(position = posicion) else new Pared(position = posicion))
        })
    }

    //mostradores en la columna 4: cada uno ocupa dos celdas (filas 6-7, 9-10, 12-13 y 15-16, contadas de 1 a 20)
    method crearMostradores() {
        [6, 9, 12, 15].forEach({ filaDeAbajo =>
            game.addVisual(new MostradorAbajo(position = game.at(3, filaDeAbajo - 1)))
            game.addVisual(new MostradorArriba(position = game.at(3, filaDeAbajo)))
        })
    }

    //escritorios verticales (columna 8, filas 11-12 y 14-15, contadas de 1 a 20): todavia no hay assets en vertical, se usan las mitades del escritorio del gerente
    method crearEscritorios() {
        [11, 14].forEach({ filaDeAbajo =>
            game.addVisual(new EscritorioIzquierdo(position = game.at(7, filaDeAbajo - 1)))
            game.addVisual(new EscritorioDerecho(position = game.at(7, filaDeAbajo)))
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

    method agregarDinero() {
        const agregar = { dinero =>
            game.addVisual(dinero)
            game.onCollideDo(dinero, { personaje => personaje.chocarConDinero(dinero) })
            itemsDeLaPartida.add(dinero)
        }
        //las celdas se cuentan de 1 a 20 (como en pantalla): se resta 1 para el juego
        const celda = { c => game.at(c.get(0) - 1, c.get(1) - 1) }
        const monedas = [[19, 17], [19, 18], [19, 19], [7, 8], [8, 8], [9, 12], [9, 15], [5, 6], [5, 9], [5, 12]]
        const bolsas = [[5, 15], [7, 11], [7, 14], [19, 5], [19, 6], [19, 12], [12, 6], [12, 7], [12, 5], [12, 8], [19, 13], [19, 14], [19, 15]]
        const diamantes = [[17, 8], [18, 8], [19, 8], [9, 5], [17, 9], [18, 9], [19, 9]]
        monedas.forEach({ c => agregar.apply(new Moneda(position = celda.apply(c))) })
        bolsas.forEach({ c => agregar.apply(new BolsaDeDinero(position = celda.apply(c))) })
        diamantes.forEach({ c => agregar.apply(new Diamante(position = celda.apply(c))) })
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
        self.agregarDinero()
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