import wollok.game.*
import pantallas.gameover.*

//el camion ocupa dos celdas por cuestiones decorativas
//este objeto es la parte de adelante y tiene toda la logica de la entrega
object camion{
    const property position = game.at(1, 0)

    method image() = "camionAdelante.png"

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

//parte de atras del camio, se comporta igual que la de adelante porque delega todo en camion
object camionAtras{
    const property position = game.at(2, 0)

    method image() = "camionAtras.png"

    method sePuedeAtravesarLadron() = camion.sePuedeAtravesarLadron()
    method sePuedeAtravesarPolicia() = camion.sePuedeAtravesarPolicia()

    method recibirImpactoDe(proyectil){ camion.recibirImpactoDe(proyectil) }
}

class Pared {
  const property position = game.origin()
  method image() = "pared.jpg"
  method sePuedeAtravesarLadron() = false
  method sePuedeAtravesarPolicia() = false

  method recibirImpactoDe(proyectil){ proyectil.destruir() }
}

//igual que una pared pero con la imagen de las barreras de la calle
class BarreraVial inherits Pared {
  override method image() = "barreraVial2.png"
}

//auto de policia de decoracion es un obstaculo fijo
object autoPolicia inherits Pared(position = game.at(18, 0)) {
  override method image() = "autoPolicia.png"
}

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

object vidas {
    const property position = game.at(2, 19)
    var property restantes = 3

    method text() = "Vidas: " + restantes

    method perderVida(danio) {
        restantes = (restantes - danio).max(0)
    }

    method seAgotaron() = restantes <= 0

    method recibirImpactoDe(proyectil){}

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