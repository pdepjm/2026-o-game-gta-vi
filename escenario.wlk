import wollok.game.*

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
}

object vidas {
    const property position = game.at(1,18)
    var cantidad = 3

    method text() = "Vidas: " + cantidad

    method perderUnaVida() {
      cantidad -= 1
    }

    method cantidad() = cantidad

    method seAgotaron() = cantidad <= 0

    method recibirImpactoDe(proyectil){}

    //es solo texto de HUD, no bloquea a nadie
    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}