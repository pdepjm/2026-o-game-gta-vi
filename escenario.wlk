import wollok.game.*
import banco.*
import hud.*

//el camion ocupa dos celdas por cuestiones decorativas
//este objeto es la parte de adelante y tiene toda la logica de la entrega
object camion{
    const property position = game.at(1, 0)

    method image() = "camionAdelante.png"

    method recibir(dinero){
        puntaje.sumar(dinero.valor())
        banco.entregaRealizada()
    }

    //el camion recibe la carga y hace que el ladron no lo pueda atravesar
    method chocarConLadron(ladron){
        ladron.entregarCargaA(self)
        ladron.retroceder()
    }

    //el ladron "atraviesa" para entrar a la celda y que la colision dispare la entrega: despues chocarConLadron lo hace retroceder
    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = false

    method recibirImpactoDe(proyectil){}

}

//parte de atras del camion, se comporta igual que la de adelante porque delega todo en camion
object camionAtras{
    const property position = game.at(2, 0)

    method image() = "camionAtras.png"

    method sePuedeAtravesarLadron() = camion.sePuedeAtravesarLadron()
    method sePuedeAtravesarPolicia() = camion.sePuedeAtravesarPolicia()

    method recibirImpactoDe(proyectil){ camion.recibirImpactoDe(proyectil) }
}

class Pared {
  const property position = game.origin()
  method image() = "pared.png"
  method sePuedeAtravesarLadron() = false
  method sePuedeAtravesarPolicia() = false

  method recibirImpactoDe(proyectil){ proyectil.destruir() }
}

//igual que una pared pero con la imagen de las barreras de la calle
class BarreraVial inherits Pared {
  override method image() = "barreraVial2.png"
}

//cada mostrador ocupa dos celdas: la de abajo y la de arriba
class MostradorAbajo inherits Pared {
  override method image() = "mostradorAbajo.png"
}

class MostradorArriba inherits Pared {
  override method image() = "mostradorArriba.png"
}

//cada escritorio vertical ocupa dos celdas: la de abajo y la de arriba
class EscritorioVerticalAbajo inherits Pared {
  override method image() = "escritorioVerticalAbajo.png"
}

class EscritorioVerticalArriba inherits Pared {
  override method image() = "escritorioVerticalArriba.png"
}

//el escritorio del gerente es horizontal: ocupa una celda izquierda y una derecha
object escritorioGerenteIzquierdo inherits Pared(position = game.at(8, 5)) {
    override method image() = "escritorioGerenteIzq.png"
}

object escritorioGerenteDerecho inherits Pared(position = game.at(9, 5)) {
    override method image() = "escritorioGerenteDer.png"
}

//auto de policia de decoracion, es un obstaculo fijo
object autoPolicia inherits Pared(position = game.at(18, 0)) {
  override method image() = "autoPolicia.png"
}
