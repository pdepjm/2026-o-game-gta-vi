import pantallas.pantalla.*
import pantallas.reglas.*
import pantallas.gestorPantallas.*

object pantallaInicio inherits Pantalla {
    override method image() = "inicio.png"

    override method accionarEnter() {
        gestorPantallas.mostrar(pantallaReglas)
    }
}