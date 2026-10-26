import wollok.game.*
import banco.*

//lo comun a todo el dinero esta aca: cada tipo solo define su valor, su imagen y como afecta al ladron al cargarlo
class Dinero{
    const property position = game.origin()

    method valor()
    method image()

    method serRecogidoPor(ladron){ ladron.cargar(self) }

    //este dinero es la carga actual del ladron, no puede levantar otro
    method dejarCargar(otroDinero, ladron){}

    //el dinero sale del banco recien cuando el ladron realmente lo toma
    method cargarseEn(ladron){
        banco.retirar(self)
        ladron.tomar(self)
    }

    method serEntregadoA(camion){ camion.recibir(self) }

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