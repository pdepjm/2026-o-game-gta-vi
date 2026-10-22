import wollok.game.*
import personaje.*

object ladron inherits Personaje(posicionInicial = game.at(1, 1)) {
    const velocidadBase = 265
    var velocidad = velocidadBase
    var ultimoMovimiento = 0
    var objetoQueCarga = null
    const vidasMaximas = 3
    var vidasRestantes = vidasMaximas
    //lo que pasa cuando se queda sin vidas lo define quien arma el juego: el ladron no conoce el flujo de la partida
    var accionAlMorir = {}

    override method image() = direccion.imagenLadron()

    override method celdaLibre(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarLadron() })

    method pasoElTiempoDeMovimiento() = game.currentTime() - ultimoMovimiento >= velocidad

    override method moverA(destino) {
        if (self.pasoElTiempoDeMovimiento() and self.celdaLibre(destino)) {
            ultimoMovimiento = game.currentTime()
            super(destino)
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

    method entregarCargaA(camion) {
        if (not self.tieneManosLibres()) {
            const dinero = objetoQueCarga
            objetoQueCarga = null
            velocidad = velocidadBase
            camion.recibir(dinero)
        }
    }

    method vidasRestantes() = vidasRestantes

    method alMorir(accion) { accionAlMorir = accion }

    method recibirImpactoDe(proyectil) {
        self.recibirDisparo(proyectil.danioProyectil())
        proyectil.destruir()
    }

    method recibirDisparo(danio) {
        vidasRestantes = (vidasRestantes - danio).max(0)
        if (vidasRestantes == 0) {
            accionAlMorir.apply()
        }
    }

    method modificarVelocidad(modificador){ velocidad += modificador }

    override method reiniciar() {
        super()
        objetoQueCarga = null
        velocidad = velocidadBase
        vidasRestantes = vidasMaximas
    }
}
