import wollok.game.*

object camion{
    const property position = game.origin()
    var dineroAcumulado = 0

    method image() = "camion2.png"

    method dineroAcumulado() = dineroAcumulado

    method recibirEntregaDe(ladron){
        dineroAcumulado += ladron.valorCarga()
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
