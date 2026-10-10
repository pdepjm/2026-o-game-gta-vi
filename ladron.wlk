import wollok.game.*
import personaje.*
import escenario.*

object ladron inherits Personaje(position = game.at(0, 1)) {
    const velocidadBase = 265
    var velocidad = velocidadBase
    var ultimoMovimiento = 0
    var objetoQueCarga = null

    override method image() = "ladron2.png"

    override method celdaLibre(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarLadron() })

    method pasoElTiempoDeMovimiento() = game.currentTime() - ultimoMovimiento >= velocidad

    override method moverA(destino) {
        if (self.pasoElTiempoDeMovimiento() and self.celdaLibre(destino)) {
            ultimoMovimiento = game.currentTime()
            posicionAnterior = position
            position = destino
        }
    }

    method sePuedeAtravesarPolicia() = false

    method chocarConDinero(dinero){ dinero.serRecogidoPor(self) }
    method chocarConCamion(camion){ camion.chocarConLadron(self) }
    method chocarConMunicion(municion){}
    method chocarConArma(arma){}

    method cargar(dinero){
        if(self.tieneManosLibres()){
            objetoQueCarga = dinero
            dinero.alSerCargadoPor(self)
            game.removeVisual(dinero)
        }
    }

    method tieneManosLibres() = objetoQueCarga == null
    method valorCarga() = if (self.tieneManosLibres()) 0 else objetoQueCarga.valor()

    method entregarCarga() {
        objetoQueCarga = null
        velocidad = velocidadBase
    }

    method recibirImpactoDe(proyectil) {
        self.recibirDisparo(proyectil.danioProyectil())
        proyectil.destruir()
    }

    method recibirDisparo(danio) {
        vidas.perderVida(danio)
        if (vidas.seAgotaron()) {
            game.removeVisual(self)
        }
    }

    method modificarVelocidad(modificador){ velocidad += modificador }
}
