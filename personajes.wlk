import wollok.game.*

object ladron{
    var property position = game.origin()
    //var vidas = 3
    //var velocidad = 5

    method image() = "ladron.png"

    method moverseArriba()    { position = position.up(1) }
    method moverseAbajo()     { position = position.down(1) }
    method moverseIzquierda() { position = position.left(1) }
    method moverseDerecha()   { position = position.right(1) }

    method cargar(dinero){}

    method tieneManosLibres(){}

    method entregarCarga(){}

    method recibirDisparo(){}

    method atacar(){}

    method modificarVelocidad(){}

}

object policia{
    var property position = game.origin()
    //var arma
    //var direccionDondeMira
    var aturdido = false

    method image() = "policia.png"

    method moverseArriba()    { position = position.up(1) }
    method moverseAbajo()     { position = position.down(1) }
    method moverseIzquierda() { position = position.left(1) }
    method moverseDerecha()   { position = position.right(1) }

    method disparar(){}

    method aturdir(){ aturdido = true}

    method puedeActuar() = !aturdido // se consulta cuando se quiere disparar o moverse
}

