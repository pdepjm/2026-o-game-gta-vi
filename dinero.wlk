import wollok.game.*

class Moneda{
    const property valor = 10
    const property position = game.origin()

    method image() = "moneda2.jpg"

    method serRecogidoPor(ladron){
        ladron.cargar(self)
    }

    method alSerCargadoPor(ladron){}

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true

    method recibirImpactoDe(proyectil){}
}

class BolsaDeDinero{
    const property valor = 100
    const property position = game.origin()

    method image() = "bolsaDeDinero2.png"

    method serRecogidoPor(ladron){
        ladron.cargar(self)
    }

    method alSerCargadoPor(ladron){
        ladron.modificarVelocidad(-100)
    }

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true

    method recibirImpactoDe(proyectil){}
}

class Diamante{
    const property valor = 500
    const property position = game.origin()

    method image() = "diamante2.png"

    method serRecogidoPor(ladron){
        ladron.cargar(self)
    }

    method alSerCargadoPor(ladron){
        ladron.modificarVelocidad(100)
    }

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true

    method recibirImpactoDe(proyectil){}
}
