import wollok.game.*
import personaje.*

object policia inherits Personaje(position = game.at(18, 10)) {
    var armaActual = null

    method image() = "policia2.jpg"

    override method celdaLibre(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarPolicia() })

    method sePuedeAtravesarLadron() = false

    method chocarConDinero(dinero){}
    method chocarConCamion(camion){}
    method chocarConMunicion(municion){
        if (self.tieneArmaEquipada()) { municion.serRecogidaPor(self) }
    }

    method tieneArmaEquipada() = armaActual != null
    method recibirImpactoDe(proyectil){}
    method chocarConArma(arma){ self.tomarArma(arma) }

    method tomarArma(arma){
        armaActual = arma
        game.removeVisual(arma)
    }

    method disparar(){
        if (self.tieneArmaEquipada()) {
            armaActual.disparar(position, direccion)
        }
    }

    method recargar(){
        if (self.tieneArmaEquipada()) {
            armaActual.recargar()
        }
    }
}
