import wollok.game.*

class Moneda{
    const property valor = 10
    var property position = game.origin()

    method image() = "moneda2.jpg"

    method serRecogidoPor(ladron){
        ladron.cargar(self)
    }

    method alSerCargadoPor(ladron){}

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}

class BolsaDeDinero{
    const property valor = 100
    var property position = game.origin()

    method image() = "bolsaDeDinero2.png"

    method serRecogidoPor(ladron){
        ladron.cargar(self)
    }

    method alSerCargadoPor(ladron){
        ladron.modificarVelocidad(1)
    }

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}

class Diamante{
    const property valor = 500
    var property position = game.origin()

    method image() = "diamante2.png"

    method serRecogidoPor(ladron){
        ladron.cargar(self)
    }

    method alSerCargadoPor(ladron){
        ladron.modificarVelocidad(-1)
    }

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true
}
