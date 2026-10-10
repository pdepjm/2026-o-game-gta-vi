import pantallas.pantalla.*
import pantallas.reglas.*
import gestorJuego.*

object pantallaInicio inherits Pantalla {
    override method image() = "inicio.png"

    override method accionarEnter() {
        gestorJuego.mostrarPantalla(pantallaReglas)
    }
}