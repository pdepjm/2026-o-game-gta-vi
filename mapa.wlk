import wollok.game.*
import escenario.*
import ladron.*
import policia.*
import armas.*
import municion.*
import tablero.*

//maneja los elementos del mapa: el escenario fijo del banco y la calle (paredes, mostradores, escritorios y decorado)
//y lo que aparece y desaparece en cada partida (camion, personajes, armas y municiones). El dinero lo maneja el banco
object mapa {
    
    var itemsDeLaPartida = []

    //se llama UNA sola vez, al arrancar el programa
    method armar() {
        self.crearParedes()
        self.crearMostradores()
        self.crearEscritorios()
        self.crearDecorado()
    }

    method crearParedes() {
        //las celdas que caen en la calle (filas 1 a 3) son barreras viales; el resto, paredes
        const ultimaFilaDeLaCalle = 3
        self.celdasDeParedes().forEach({ c =>
            const posicion = game.at(c.get(0) - 1, c.get(1) - 1)
            game.addVisual(if (c.get(1) <= ultimaFilaDeLaCalle) new BarreraVial(position = posicion) else new Pared(position = posicion))
        })
    }

    //celdas contadas de 1 a 20 (como en pantalla), sin repetir las esquinas y cruces donde dos lineas comparten celda
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

    method crearDecorado() {
        game.addVisual(autoPolicia)
        game.addVisual(escritorioGerenteIzquierdo)
        game.addVisual(escritorioGerenteDerecho)
    }

    //se llama al empezar cada partida
    method mostrar() {
        self.agregarArmas()
        self.agregarMuniciones()
        self.agregarPersonajes()
    }

    //se llama al terminar cada partida
    method ocultar() {
        self.sacarPersonajes()
        self.sacarItems()
    }

    method agregarArmas() {
        const agregar = { arma =>
            tablero.agregar(arma, { personaje => personaje.chocarConArma(arma) })
            itemsDeLaPartida.add(arma)
        }
        agregar.apply(new Pistola(position = game.at(17, 0)))
        agregar.apply(new Escopeta(position = game.at(16, 0)))
    }

    method agregarMuniciones() {
        const agregar = { municion =>
            tablero.agregar(municion, { personaje => personaje.chocarConMunicion(municion) })
            itemsDeLaPartida.add(municion)
        }
        agregar.apply(new Municion(position = game.at(15, 0)))
        agregar.apply(new Municion(position = game.at(14, 0)))
    }

    method agregarPersonajes() {
        tablero.agregar(camion, { personaje => personaje.chocarConCamion(camion) })
        tablero.agregar(camionAtras, { personaje => personaje.chocarConCamion(camion) })
        game.addVisual(policia)
        game.addVisual(ladron)
    }

    method sacarPersonajes() {
        game.removeVisual(ladron)
        game.removeVisual(policia)
        tablero.quitar(camion)
        tablero.quitar(camionAtras)
    }

    method sacarItems() {
        itemsDeLaPartida.forEach({ item => tablero.quitar(item) })
        itemsDeLaPartida = []
    }
}
