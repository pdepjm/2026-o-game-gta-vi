import wollok.game.*
import escenario.*

object ladron{
    var property position = game.at(0, 1)
    const velocidadBase = 300
    var velocidad = velocidadBase
    var ultimoMovimiento = 0
    var posicionAnterior = position
    var objetoQueCarga = null

    method image() = "ladron2.png"

    method moverseArriba()    { self.moverA(position.up(1)) }
    method moverseAbajo()     { self.moverA(position.down(1)) }
    method moverseIzquierda() { self.moverA(position.left(1)) }
    method moverseDerecha()   { self.moverA(position.right(1)) }

    //una celda ocupada por algo infranqueable no se pisa, lo resuelve celdaLibre
    method moverA(destino){
        if (self.pasoElTiempoDeMovimiento() and self.celdaLibre(destino)) {
            ultimoMovimiento = game.currentTime()
            posicionAnterior = position
            position = destino
        }
    }

    //se consulta antes de moverse , asi ninguna tecla mantenida presionada
    //logra meter al ladron dentro de una pared mientras el chequeo de colision reactivo todavia no corrio
    //getObjectsIn nos dice si hay un objeto que no se puede atravesar en la celda destino, si hay alguno no se mueve
    method celdaLibre(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarLadron() })

    //currentTime nos dice el tiempo trancurrido y asi vamos a poder limitar la velocidad del ladron,no se puede mover mas rapido de lo que le permite su velocidad
    method pasoElTiempoDeMovimiento() = game.currentTime() - ultimoMovimiento >= velocidad

    method retroceder(){ position = posicionAnterior }

    //el ladron y la policia no se pueden atravesar
    method sePuedeAtravesarPolicia() = false

    method chocarConDinero(dinero){ dinero.serRecogidoPor(self) }

    method chocarConCamion(camion){ camion.chocarConLadron(self) }

    method chocarConMunicion(municion){}

    method chocarConArma(arma){}

    //con las manos ocupadas el ladron pasa por encima del dinero sin agarrarlo
    method cargar(dinero){
        if(self.tieneManosLibres()){
            objetoQueCarga = dinero
            dinero.alSerCargadoPor(self)
            game.removeVisual(dinero)
        }
    }

    method tieneManosLibres() = objetoQueCarga == null

    method valorCarga() = if (self.tieneManosLibres()) 0 else objetoQueCarga.valor()

    //al entregar se pierde el boost o penalizacion que daba el dinero cargado
    method entregarCarga(){
        objetoQueCarga = null
        velocidad = velocidadBase
    }

    method recibirImpactoDe(proyectil){
        self.recibirDisparo()
        proyectil.destruir()
    }

    method recibirDisparo(){
        vidas.perderUnaVida()
        if (vidas.seAgotaron()) {
            game.removeVisual(self)
        }
    }

    method modificarVelocidad(modificador){ velocidad += modificador } //restar va mas rapido, sumar va mas lento

}

object policia{
    var property position = game.at(18, 10)
    var posicionAnterior = position
    var armaActual = null
    var direccion = "abajo"

    method retroceder(){ position = posicionAnterior }

    //el ladron y la policia no se pueden atravesar
    method sePuedeAtravesarLadron() = false

    method chocarConDinero(dinero){}

    method chocarConCamion(camion){}

    //solo la recoge si tiene un arma equipada
    method chocarConMunicion(municion){
        if (self.tieneArmaEquipada()) { municion.serRecogidaPor(self) }
    }

    method tieneArmaEquipada() = armaActual != null

    //el disparo propio no lastima a la policia
    method recibirImpactoDe(proyectil){}

    method image() = "policia2.jpg"

    //necesitamos saber la direccion para disparar hacia donde mira el policia
    method moverseArriba()    { direccion = "arriba";    self.moverA(position.up(1)) }
    method moverseAbajo()     { direccion = "abajo";     self.moverA(position.down(1)) }
    method moverseIzquierda() { direccion = "izquierda"; self.moverA(position.left(1)) }
    method moverseDerecha()   { direccion = "derecha";   self.moverA(position.right(1)) }


    method moverA(destino){
        if (self.celdaLibre(destino)) {
            posicionAnterior = position
            position = destino
        }
    }

    method celdaLibre(destino) = game.getObjectsIn(destino).all({ objeto => objeto.sePuedeAtravesarPolicia() })

    method chocarConArma(arma){ self.tomarArma(arma) }

    method tomarArma(arma){
        armaActual = arma
        game.removeVisual(arma)
    }

    //delegamos el disparo al arma actual, en la direccion hacia la que esta mirando
    method disparar(){
        if (self.tieneArmaEquipada()) {
            armaActual.disparar(position, direccion)
        }
    }

    //delega en Pistola.recargar(), que ya sabe a cuanto topear la municion
    method recargar(){
        if (self.tieneArmaEquipada()) {
            armaActual.recargar()
        }
    }

}

