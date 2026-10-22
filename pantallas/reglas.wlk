import pantallas.pantalla.*
import gestorJuego.*

object pantallaReglas inherits Pantalla {
    override method image() = "reglas.png"

    override method accionarEnter() {
        gestorJuego.comenzarJuego()
    }
}