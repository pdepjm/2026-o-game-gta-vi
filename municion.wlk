import wollok.game.*
import tablero.*

class Municion {
  const property position = game.origin()

  method image() = "municion.png"
  method sePuedeAtravesarPolicia() = true
  method sePuedeAtravesarLadron() = true

  //solo se recoge si quien la toca tiene un arma que recargar
  method serRecogidaPor(policia){
    policia.recargar()
    tablero.quitar(self)
  }

}
