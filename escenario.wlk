import wollok.game.*
import pantallas.gameover.*

object camion{
    const property position = game.origin()

    method image() = "camion2.png"

    method recibirEntregaDe(ladron){
        puntaje.sumar(ladron.valorCarga())
        ladron.entregarCarga()
    }

    //el camion recibe la carga y hace que el ladron no lo pueda atravesar
    method chocarConLadron(ladron){
        self.recibirEntregaDe(ladron)
        ladron.retroceder()
    }

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = false

    method recibirImpactoDe(proyectil){}

}
class Pared {
  const property position = game.origin()
  method image() = "pared.jpg"
  method sePuedeAtravesarLadron() = false
  method sePuedeAtravesarPolicia() = false

  method recibirImpactoDe(proyectil){ proyectil.destruir() }
}

object puntaje {
    const property position = game.at(1, 19)
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

object vidas {
    const property position = game.at(1, 18)
    var property restantes = 3

    method text() = "Vidas: " + restantes

    method perderVida(danio) {
        restantes = (restantes - danio).max(0)
    }

    method seAgotaron() = restantes <= 0

    method reiniciar() { restantes = 3 }

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}

// Puntaje mostrado en la pantalla GameOver
object puntajeFinal {
    var property position = game.at(6, 12) 

    method text() = "Puntaje final: " + puntaje.puntos()
    method textColor() = "000000FF"

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}