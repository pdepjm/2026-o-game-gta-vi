import wollok.game.*
import escenario.*

//arma el escenario fijo del banco y la calle: paredes, mostradores, escritorios y decorado
object mapa {

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
}
