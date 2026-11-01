import wollok.game.*
import personaje.*
import efectos.*

object ladron inherits Personaje(posicionInicial = game.at(1, 1)) {
    const velocidadBase = 265
    var velocidad = velocidadBase
    var ultimoMovimiento = 0
    var objetoQueCarga = sinCarga
    const vidasMaximas = 3
    var vidasRestantes = vidasMaximas
    //lo que pasa cuando se queda sin vidas lo define quien arma el juego: el ladron no conoce el flujo de la partida
    var accionAlMorir = {}

    override method image() = direccion.imagenLadron()

    method objetoQueCarga() = objetoQueCarga

    override method puedeAtravesarLoQueHayEn(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarLadron() })

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

    //la carga actual decide si deja levantar otro dinero. Con sinCarga se levanta, con un dinero en las manos no
    method cargar(dinero){ objetoQueCarga.dejarCargar(dinero, self) }

    method tomar(dinero){
        objetoQueCarga = dinero
        dinero.alSerCargadoPor(self)
    }

    method entregarCargaA(camion) {
        const carga = objetoQueCarga
        objetoQueCarga = sinCarga
        velocidad = velocidadBase
        carga.serEntregadoA(camion)
    }

    method vidasRestantes() = vidasRestantes

    method alMorir(accion) { accionAlMorir = accion }

    method recibirImpactoDe(proyectil) {
        sonidoImpactoBala.sonar()
        self.recibirDisparo(proyectil.danioProyectil())
        proyectil.destruir()
    }

    method recibirDisparo(danio) {
        vidasRestantes = (vidasRestantes - danio).max(0)
        if (vidasRestantes == 0) {
            sonidoMuerteLadron.sonar()
            accionAlMorir.apply()
        }
    }

    method modificarVelocidad(modificador){ velocidad += modificador }

    override method reiniciar() {
        super()
        objetoQueCarga = sinCarga
        velocidad = velocidadBase
        vidasRestantes = vidasMaximas
    }
}

//el ladron con las manos vacias: deja levantar dinero y no tiene nada para entregar
object sinCarga{
    method dejarCargar(dinero, ladron){ dinero.cargarseEn(ladron) }

    method serEntregadoA(camion){}

    override method toString() = "sin carga"
}
