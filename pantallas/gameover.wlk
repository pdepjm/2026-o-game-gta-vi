import pantallas.pantalla.*
import gestorJuego.*

object pantallaGameOver inherits Pantalla {
    override method image() = "gameover.png"

    override method accionarEnter() {
        gestorJuego.volverAlInicio()
    }
}