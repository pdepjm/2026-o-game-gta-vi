import wollok.game.*
import ladron.*
import policia.*

class FondoDeTexto {
    const property position
    const imagen

    method image() = imagen

}

object puntaje {
    const property position = game.at(9, 19)
    var puntos = 0

    method text() = "               Puntos: " + puntos
    method textColor() = "FF69B4FF" // Rosa

    method sumar(cantidad) {
        puntos += cantidad
    }

    method puntos() = puntos

    method reiniciar() { puntos = 0 }
}

//muestra las vidas del ladron: las vidas son del ladron, el HUD solo las lee
object vidas {
    const property position = game.at(1, 19)

    method text() = "Vidas: " + ladron.vidasRestantes()
    method textColor() = "FFD700FF" // Amarillo dorado
}

//muestra lo que carga el ladron
object cargaDelLadron {
    const property position = game.at(3, 19)

    method text() = "Carga: " + ladron.objetoQueCarga()
    method textColor() = "FFD700FF" // Amarillo dorado
}

//muestra el arma que tiene equipada el policia
object armaDelPolicia {
    const property position = game.at(16, 19)

    method text() = "Arma: " + policia.armaActual()
    method textColor() = "FFFFFFFF" // Blanco
}

//muestra las balas que le quedan al arma del policia
object municionDelPolicia {
    const property position = game.at(18, 19)

    method text() = "Balas: " + policia.armaActual().balasEnCargador()
    method textColor() = "FFFFFFFF" // Blanco
}

//agrupa los textos que se muestran durante la partida
object hud {
    //la parte del ladron (columnas 0 a 4, contadas desde 0: las vidas y la carga) lleva fondo azul
    const fondosDelLadron = (0..4).map({ columna => new FondoDeTexto(position = game.at(columna, 19), imagen = "barraAzul.png") })

    //los puntos (9 y 10: el texto tiene espacios a la izquierda para quedar en el centro) llevan fondo negro
    const fondosDelPuntaje = (9..10).map({ columna => new FondoDeTexto(position = game.at(columna, 19), imagen = "barraNegra.png") })

    //la parte del policia (columnas 15 a 19: el arma y las balas) lleva fondo rojo
    const fondosDelPolicia = (15..19).map({ columna => new FondoDeTexto(position = game.at(columna, 19), imagen = "barraRoja.png") })

    //primero los fondos y despues los textos, asi los textos se dibujan encima
    const elementos = fondosDelLadron + fondosDelPuntaje + fondosDelPolicia + [puntaje, vidas, cargaDelLadron, armaDelPolicia, municionDelPolicia]

    method mostrar() {
        elementos.forEach({ elemento => game.addVisual(elemento) })
    }

    method ocultar() {
        elementos.forEach({ elemento => game.removeVisual(elemento) })
    }
}

// Puntaje mostrado en la pantalla GameOver
object puntajeFinal {
    const property position = game.at(6, 12)

    method text() = "Puntaje final: " + puntaje.puntos()
    method textColor() = "000000FF"
}
