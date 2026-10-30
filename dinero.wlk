import wollok.game.*
import banco.*
import efectos.*

//lo comun a todo el dinero esta aca: cada tipo solo define su valor, su imagen y como afecta al ladron al cargarlo
class Dinero{
    const property position = game.origin()
    const valor
    const imagen
    const modificadorVelocidad
    const nombre
    const sonido

    method valor() = valor
    method image() = imagen

    //es el nombre que se muestra en el HUD
    override method toString() = nombre

    method serRecogidoPor(ladron){ ladron.cargar(self) }

    //este dinero es la carga actual del ladron, no puede levantar otro
    method dejarCargar(otroDinero, ladron){}

    //el dinero sale del banco recien cuando el ladron realmente lo toma
    method cargarseEn(ladron){
        banco.retirar(self)
        ladron.tomar(self)
        sonido.sonar()
    }

    method serEntregadoA(camion){ camion.recibir(self) }

    method alSerCargadoPor(ladron){
        ladron.modificarVelocidad(modificadorVelocidad)
    }

    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true

    method recibirImpactoDe(proyectil){}
}
