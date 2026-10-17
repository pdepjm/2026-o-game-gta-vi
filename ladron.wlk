import gestorJuego.*
import wollok.game.*
import personaje.*
import escenario.*

object ladron inherits Personaje(position = game.at(1, 1)) {
    const velocidadBase = 265
    var velocidad = velocidadBase
    var ultimoMovimiento = 0
    var objetoQueCarga = null

    override method image() = direccion.imagenLadron()

    override method posicionInicial() = game.at(1, 1)

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
        objetoQueCarga = dinero
        dinero.alSerCargadoPor(self)
    }

    method tieneManosLibres() = objetoQueCarga == null
    method valorCarga() = if (self.tieneManosLibres()) 0 else objetoQueCarga.valor()

    method entregarCargaA(camion) {
        if (not self.tieneManosLibres()) {
            const dinero = objetoQueCarga
            objetoQueCarga = null
            velocidad = velocidadBase
            camion.recibir(dinero)
        }
    }

    method recibirImpactoDe(proyectil) {
        self.recibirDisparo(proyectil.danioProyectil())
        proyectil.destruir()
    }

    method recibirDisparo(danio) {
        vidas.perderVida(danio)
        if (vidas.seAgotaron()) {
            gestorJuego.gameover()
        }
    }

    method modificarVelocidad(modificador){ velocidad += modificador }

    override method reiniciar() {
        super()
        objetoQueCarga = null
        velocidad = velocidadBase
    }
}