import wollok.game.*

class Pistola {
  var property municion = 5
  var property position = game.at(14, 12)


  method image() = "pistola.jpg"
  method sePuedeAtravesarPolicia() = true
  method sePuedeAtravesarLadron() = true

  method policiaEquipaArma(policia) {
    policia.tomarArma(self)
  }
}

object escopeta {
  
}