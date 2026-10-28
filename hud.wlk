import wollok.game.*
import ladron.*
import policia.*

object puntaje {
    const property position = game.at(1, 18)
    var puntos = 0

    method text() = "Puntos: " + puntos
    method textColor() = "FF0000FF" // Rojo

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
    const property position = game.at(1, 17)
    method textColor() = "009933FF" // Verde

    method text() = "Vidas: " + ladron.vidasRestantes()

    method recibirImpactoDe(proyectil){}

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}

// Muestra el objeto actual que carga el ladron
object objetoQueCarga {
    const property position = game.at(1, 16)
    method textColor() = "009933FF" // Verde

    method text() = "Carga: " + ladron.objetoQueCarga()

    method recibirImpactoDe(proyectil){}

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}

// Muestra el arma actual del policia
object armaActualDelPolcia {
    const property position = game.at(17,18)

    method text() = "Arma equipada: " + policia.armaActual()
    method textColor() = "FF0000FF" // Rojo

    method recibirImpactoDe(proyectil){}

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}

// Muestra el arma actual del policia
object municionDelArmaDelPolicia {
    const property position = game.at(17,17)

    method text() = "Munición: " + policia.armaActual().balasEnCargador()
    method textColor() = "FF0000FF" // Rojo

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

