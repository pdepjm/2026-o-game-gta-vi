import wollok.game.*
import banco.*
import hud.*
import efectos.*
import elementoDelTablero.*

//el camion ocupa dos celdas por cuestiones decorativas
//este objeto es la parte de adelante y tiene toda la logica de la entrega
object camion inherits ElementoDelTablero {
    const property position = game.at(1, 0)

    method image() = "camionAdelante.png"

    method recibir(dinero){
        puntaje.sumar(dinero.valor())
        sonidoEntrega.sonar()
        banco.entregaRealizada()
    }

    //el camion recibe la carga y hace que el ladron no lo pueda atravesar
    method chocarConLadron(ladron){
        ladron.entregarCargaA(self)
        ladron.retroceder()
    }

    //el ladron entra a la celda (lo atraviesa) para que su llegada dispare la entrega: despues chocarConLadron lo hace retroceder
    override method reaccionarAlLlegar(quienLlego){ quienLlego.chocarConCamion(self) }

    override method sePuedeAtravesarPolicia() = false
}

//parte de atras del camion, se comporta igual que la de adelante porque delega todo en camion
object camionAtras inherits ElementoDelTablero {
    const property position = game.at(2, 0)

    method image() = "camionAtras.png"

    override method reaccionarAlLlegar(quienLlego){ camion.reaccionarAlLlegar(quienLlego) }

    override method sePuedeAtravesarPolicia() = camion.sePuedeAtravesarPolicia()
}
