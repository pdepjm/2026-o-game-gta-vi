import wollok.game.*
import escenario.*
import ladron.*
import policia.*
import armas.*
import municion.*
import tablero.*

//maneja los elementos del mapa las celdas bloqueadas (lo que se ve como pared o mueble viene dibujado en el fondo)
//y lo que aparece y desaparece en cada partida (camion, personajes, armas y municiones). El dinero lo maneja el banco
object mapa {
    //numero de cada celda bloqueada entre comas (ej: ",19,20,40,"). en el juego se pregunta en cada movimiento
    var bloqueadas = ","
    var itemsDeLaPartida = []

    //se llama UNA sola vez, al arrancar el programa
    method armar() {
        bloqueadas = "," + self.celdasBloqueadas().map({ celda => self.clave(celda) }).join(",") + ","
    }

    //el borde del mapa esta bloqueado, asi que nadie (ni ninguna bala) llega a una posicion fuera de el
    method estaBloqueada(posicion) = bloqueadas.contains("," + self.clave(posicion) + ",")

    //cada fila tiene 20 celdas y la primera es la y = -1
    method clave(posicion) = (posicion.y() + 1) * 20 + posicion.x()

    //la ultima fila (y = -1) queda fuera de pantalla y cierra el borde de abajo para que nadie salga del mapa
    method celdasBloqueadas() = [
        [0, 19], [1, 19], [2, 19], [3, 19], [4, 19], [5, 19], [6, 19], [7, 19], [8, 19], [9, 19], [10, 19], [11, 19], [12, 19], [13, 19], [14, 19], [15, 19], [16, 19], [17, 19], [18, 19], [19, 19],
        [0, 18], [15, 18], [19, 18],
        [0, 17], [19, 17],
        [0, 16], [19, 16],
        [0, 15], [3, 15], [5, 15], [15, 15], [19, 15],
        [0, 14], [3, 14], [5, 14], [7, 14], [15, 14], [19, 14],
        [0, 13], [5, 13], [7, 13], [15, 13], [19, 13],
        [0, 12], [3, 12], [5, 12], [15, 12], [19, 12],
        [0, 11], [3, 11], [5, 11], [7, 11], [15, 11], [19, 11],
        [0, 10], [5, 10], [7, 10], [15, 10], [19, 10],
        [0, 9], [3, 9], [5, 9], [15, 9], [19, 9],
        [0, 8], [3, 8], [5, 8], [6, 8], [7, 8], [10, 8], [11, 8], [12, 8], [15, 8], [19, 8],
        [0, 7], [5, 7], [12, 7], [15, 7], [19, 7],
        [0, 6], [3, 6], [5, 6], [12, 6], [15, 6], [16, 6], [17, 6], [18, 6], [19, 6],
        [0, 5], [3, 5], [5, 5], [8, 5], [9, 5], [12, 5], [19, 5],
        [0, 4], [5, 4], [12, 4], [19, 4],
        [0, 3], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3], [8, 3], [9, 3], [10, 3], [11, 3], [12, 3], [13, 3], [14, 3], [15, 3], [16, 3], [18, 3], [19, 3],
        [0, 2], [19, 2],
        [0, 1], [19, 1],
        [0, 0], [18, 0], [19, 0],
        [0, -1], [1, -1], [2, -1], [3, -1], [4, -1], [5, -1], [6, -1], [7, -1], [8, -1], [9, -1], [10, -1], [11, -1], [12, -1], [13, -1], [14, -1], [15, -1], [16, -1], [17, -1], [18, -1], [19, -1]
    ].map({ celda => game.at(celda.get(0), celda.get(1)) })

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
        self.agregarArma(new Pistola(position = game.at(17, 0)))
        self.agregarArma(new Escopeta(position = game.at(16, 0)))
    }

    method agregarArma(arma) {
        tablero.agregar(arma, { personaje => personaje.chocarConArma(arma) })
        itemsDeLaPartida.add(arma)
    }

    //despues de que el policia toma un arma, otra igual aparece en la misma celda despues de un tiempo
    method reaparecerArma(arma) {
        if (itemsDeLaPartida.contains(arma)) { self.agregarArma(arma.nuevaEnLaMismaCelda()) }
    }

    method agregarMuniciones() {

        self.agregarMunicion(new Municion(position = game.at(18, 1)))
        self.agregarMunicion(new Municion(position = game.at(18, 2)))
    }

    method agregarMunicion(municion) {
        self.mostrarMunicion(municion)
        itemsDeLaPartida.add(municion)
    }

    method mostrarMunicion(municion) {
        tablero.agregar(municion, { personaje => personaje.chocarConMunicion(municion) })
    }

    //la municion que el policia recogio vuelve a aparecer en su celda
    method reaparecerMunicion(municion) {
        if (itemsDeLaPartida.contains(municion)) { self.mostrarMunicion(municion) }
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
