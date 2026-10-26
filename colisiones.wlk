import wollok.game.*
import escenario.*

//configura las colisiones fijas del escenario (las de dinero, armas y municiones se registran al aparecer cada una)
object colisiones {

    //se llama solo al arrancar el programa
    method configurar() {
        game.onCollideDo(camion, { personaje => personaje.chocarConCamion(camion) })
        game.onCollideDo(camionAtras, { personaje => personaje.chocarConCamion(camion) })
    }
}
