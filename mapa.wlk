import wollok.game.*
import camion.*
import ladron.*
import policia.*
import armas.*
import municion.*

//maneja lo que aparece y desaparece en cada partida: el camion, los personajes, las armas y las municiones
//el dinero lo maneja el banco y las paredes y los muebles son celdas bloqueadas
object mapa {
    //milisegundos que tarda en volver a aparecer un arma o una municion despues de que la tomaron
    const tiempoDeReaparicion = 30000
    const itemsDeLaPartida = []

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
        self.agregar(new Pistola(position = game.at(17, 0)))
        self.agregar(new Escopeta(position = game.at(16, 0)))
    }

    method agregarMuniciones() {
        self.agregar(new Municion(position = game.at(18, 1)))
        self.agregar(new Municion(position = game.at(18, 2)))
    }

    //las armas y las municiones se anotan como de la partida para saber, cuando les toque reaparecer, si la partida sigue siendo la misma
    method agregar(item) {
        game.addVisual(item)
        itemsDeLaPartida.add(item)
    }

    //el item avisa que lo tomaron y vuelve a aparecer despues de un tiempo
    method itemTomado(item) {
        game.schedule(tiempoDeReaparicion, { self.reaparecer(item) })
    }

    //si la partida ya termino el item no esta mas entre los de la partida y no reaparece
    //el que reaparece reemplaza al item tomado: una arma nueva con el cargador lleno, o la misma municion
    method reaparecer(item) {
        if (itemsDeLaPartida.contains(item)) {
            itemsDeLaPartida.remove(item)
            self.agregar(item.elQueReaparece())
        }
    }

    method agregarPersonajes() {
        game.addVisual(camion)
        game.addVisual(camionAtras)
        game.addVisual(policia)
        game.addVisual(ladron)
    }

    method sacarPersonajes() {
        game.removeVisual(ladron)
        game.removeVisual(policia)
        game.removeVisual(camion)
        game.removeVisual(camionAtras)
    }

    method sacarItems() {
        itemsDeLaPartida.forEach({ item => game.removeVisual(item) })
        itemsDeLaPartida.clear()
    }
}
