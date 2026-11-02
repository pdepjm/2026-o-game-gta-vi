import wollok.game.*
import personaje.*
import efectos.*

object policia inherits Personaje(posicionInicial = game.at(17, 1)) {
    var armaActual = sinArma

    override method image() = direccion.imagenPolicia()
    method armaActual() = armaActual

    override method puedeAtravesarLoQueHayEn(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarPolicia() })

    override method sePuedeAtravesarLadron() = false

    method chocarConDinero(dinero){}
    method chocarConCamion(camion){}
    method chocarConMunicion(municion){ armaActual.recogerMunicion(municion, self) }

    method chocarConArma(arma){ self.tomarArma(arma) }

    method tomarArma(arma){
        armaActual = arma
        game.removeVisual(arma)
        sonidoEquiparArma.sonar()
        arma.alSerTomada()
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