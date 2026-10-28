import wollok.game.*
import personaje.*

object policia inherits Personaje(posicionInicial = game.at(18, 1)) {
    var armaActual = sinArma

    override method image() = direccion.imagenPolicia()
    method armaActual() = armaActual

    override method celdaLibre(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarPolicia() })

    method sePuedeAtravesarLadron() = false

    method chocarConDinero(dinero){}
    method chocarConCamion(camion){}
    method chocarConMunicion(municion){ armaActual.recogerMunicion(municion, self) }

    method recibirImpactoDe(proyectil){}
    method chocarConArma(arma){ self.tomarArma(arma) }

    method tomarArma(arma){
        armaActual = arma
        game.removeVisual(arma)
        io.removeCollitionHandler(arma.identity())
    }

    method disparar(){armaActual.disparar(position, direccion)}

    method recargar(){armaActual.recargar()}

    override method reiniciar() {
        super()
        armaActual = sinArma
    }
}

//el policia sin arma no dispara, no recarga y deja la municion en el mapa
object sinArma{
    method disparar(origen, direccion){}

    method recargar(){}

    method balasEnCargador() = 0
    method recogerMunicion(municion, policia){}

    override method toString() = "ninguna"
}