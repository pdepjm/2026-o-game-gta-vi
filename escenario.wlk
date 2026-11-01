import wollok.game.*
import banco.*
import hud.*
import efectos.*

//el camion ocupa dos celdas por cuestiones decorativas
//este objeto es la parte de adelante y tiene toda la logica de la entrega
object camion{
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
