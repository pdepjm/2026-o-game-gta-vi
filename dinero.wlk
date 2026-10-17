import wollok.game.*
import banco.*

//lo comun a todo el dinero esta aca: cada tipo solo define su valor, su imagen y como afecta al ladron al cargarlo
class Dinero{
    const property position = game.origin()

    method valor()
    method image()

    //si el ladron tiene las manos ocupadas el dinero se queda en el mapa
    method serRecogidoPor(ladron){
        if (ladron.tieneManosLibres()) {
            banco.retirar(self)
            ladron.cargar(self)
        }
    }

    method alSerCargadoPor(ladron){}

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true

    method recibirImpactoDe(proyectil){}
}

class Moneda inherits Dinero{
    override method valor() = 10

    override method image() = "moneda.png"
}

class BolsaDeDinero inherits Dinero{
    override method valor() = 100

    override method image() = "bolsa.png"

    override method alSerCargadoPor(ladron){
        ladron.modificarVelocidad(-100)
    }
}

class Diamante inherits Dinero{
    override method valor() = 500

    override method image() = "diamante.png"

    override method alSerCargadoPor(ladron){
        ladron.modificarVelocidad(100)
    }
}