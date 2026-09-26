import wollok.game.*

object camion{
    const property position = game.origin()
    // var dineroAcumulado = 0
    // method dineroAcumulado() = dineroAcumulado

    method image() = "camion2.png"

    method recibirEntregaDe(ladron){
        // dineroAcumulado += ladron.valorCarga()
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

}
class Pared {
  var property position = game.origin()
  method image() = "pared.jpg"
  method sePuedeAtravesarLadron() = false
  method sePuedeAtravesarPolicia() = false
} 

object puntaje {
    var property  position = game.at(1, 19)
    var puntos = 0
    
    method text() = "Puntos: " + puntos

    method sumar(cantidad) {
        puntos += cantidad
    }
    
    method puntos() = puntos
    
    method sePuedeAtravesarPolicia() = true
    method sePuedeAtravesarLadron() = true
}

object vidas {
    var property position = game.at(1,18)
    var cantidad = 3

    method text() = "Vidas: " + cantidad

    method perderUnaVida() {
      cantidad -= 1
    }

    method cantidad() = cantidad
    
    method seAgotaron() = cantidad <= 0
}