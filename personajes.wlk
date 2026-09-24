import wollok.game.*

/* Posible uso de clase Personaje
class Personaje {
  var property position = game.origin()

  method moverseArriba()    { position = position.up(1) }
  method moverseAbajo()     { position = position.down(1) }
  method moverseIzquierda() { position = position.left(1) }
  method moverseDerecha()   { position = position.right(1) }
  
}

*/

object ladron{
    var property position = game.origin()
    //var vidas = 3
    //var velocidad = 5
    var posicionAnterior = position
    method posicionAnterior() = posicionAnterior

    method image() = "ladron.png"

    method moverseArriba()    { 
        posicionAnterior = position 
        position = position.up(1) 
    }

    method moverseAbajo()     { 
        posicionAnterior = position
        position = position.down(1) 
    }
    method moverseIzquierda() { 
        posicionAnterior = position
        position = position.left(1) 
    }
    method moverseDerecha()   { 
        posicionAnterior = position
        position = position.right(1) 
    }

    method cargar(dinero){}

    method tieneManosLibres(){}

    method entregarCarga(){}

    method recibirDisparo(){}

    method atacar(){}

    method modificarVelocidad(){}

}

object policia{
    var property position = game.origin()
    
    // Almacenamos pos anterior para manejar colisiones con paredes
    var posicionAnterior = position
    method posicionAnterior() = posicionAnterior

    //var arma
    //var direccionDondeMira
    var aturdido = false

    method image() = "policia2.jpg" //Imagen de 50px = tamaño de las celdas

    method moverseArriba()    { 
        posicionAnterior = position 
        position = position.up(1) 
    }

    method moverseAbajo()     { 
        posicionAnterior = position
        position = position.down(1) 
    }
    method moverseIzquierda() { 
        posicionAnterior = position
        position = position.left(1) 
    }
    method moverseDerecha()   { 
        posicionAnterior = position
        position = position.right(1) 
    }

    method disparar(){}

    method aturdir(){ aturdido = true}

    method puedeActuar() = !aturdido // se consulta cuando se quiere disparar o moverse
}

