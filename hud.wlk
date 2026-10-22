import wollok.game.*
import ladron.*

object puntaje {
    const property position = game.at(0, 19)
    var puntos = 0

    method text() = "Puntos: " + puntos

    method sumar(cantidad) {
        puntos += cantidad
    }

    method puntos() = puntos

    method recibirImpactoDe(proyectil){}

    //es solo texto de HUD, no bloquea a nadie
    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true

    method reiniciar() { puntos = 0 }
}

//muestra las vidas del ladron: las vidas son del ladron, el HUD solo las lee
object vidas {
    const property position = game.at(2, 19)

    method text() = "Vidas: " + ladron.vidasRestantes()

    method recibirImpactoDe(proyectil){}

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}

// Puntaje mostrado en la pantalla GameOver
object puntajeFinal {
    const property position = game.at(6, 12)

    method text() = "Puntaje final: " + puntaje.puntos()
    method textColor() = "000000FF"

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}
