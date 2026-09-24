import wollok.game.*

object camion{
    const property position = game.origin()
    //var dineroAcumulado = 0

    method image() = "camion.png"

    method recibirEntregaDe(ladron){}

}

class Pared {
  var property position = game.origin()
  method image() = "pared.jpg"
  method sePuedeAtravesar() = false
} 
