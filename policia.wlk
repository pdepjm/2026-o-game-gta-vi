import wollok.game.*
import personaje.*

object policia inherits Personaje(position = game.at(18, 10)) {
    var armaActual = null

    override method image() = "policia2.jpg"

    override method posicionInicial() = game.at(18, 10)

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
        io.removeCollitionHandler(self.identity())
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

    override method reiniciar() {
        super()
        armaActual = null
    }
}