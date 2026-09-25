import wollok.game.*

object ladron{
    var property position = game.at(0, 1)
    //var vidas = 3
    const velocidadBase = 1
    var velocidad = velocidadBase
    var posicionAnterior = position
    var objetoQueCarga = null

    method posicionAnterior() = posicionAnterior

    method image() = "ladron2.png"

    method moverseArriba()    { self.moverA(position.up(1)) }
    method moverseAbajo()     { self.moverA(position.down(1)) }
    method moverseIzquierda() { self.moverA(position.left(1)) }
    method moverseDerecha()   { self.moverA(position.right(1)) }

    //el ladron y la policia no se pueden atravesar si la celda destino esta ocupada ninguno se mueve
    method moverA(destino){
        if (destino != policia.position()) {
            posicionAnterior = position
            position = destino
        }
    }

    method retroceder(){ position = posicionAnterior }

    method sePuedeAtravesarPolicia() = true

    method chocarConDinero(dinero){ dinero.serRecogidoPor(self) }

    method chocarConCamion(camion){ camion.chocarConLadron(self) }

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

    method recibirDisparo(){}

    method atacar(){}

    method modificarVelocidad(modificador){ velocidad += modificador }

    method velocidad() = velocidad

}

object policia{
    var property position = game.at(18, 10)
    var posicionAnterior = position
    //var arma
    //var direccionDondeMira
    var aturdido = false

    method posicionAnterior() = posicionAnterior

    method retroceder(){ position = posicionAnterior }

    method sePuedeAtravesarLadron() = true

    method chocarConDinero(dinero){}

    method chocarConCamion(camion){}

    method image() = "policia2.jpg" 

    method moverseArriba()    { self.moverA(position.up(1)) }
    method moverseAbajo()     { self.moverA(position.down(1)) }
    method moverseIzquierda() { self.moverA(position.left(1)) }
    method moverseDerecha()   { self.moverA(position.right(1)) }

    //el ladron y la policia no se pueden atravesar si la celda destino esta ocupada ninguno se mueve
    method moverA(destino){
        if (destino != ladron.position()) {
            posicionAnterior = position
            position = destino
        }
    }

    method disparar(){}

    method aturdir(){ aturdido = true}

    method puedeActuar() = !aturdido // se consulta cuando se quiere disparar o moverse
}

