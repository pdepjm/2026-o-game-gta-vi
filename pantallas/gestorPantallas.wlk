import pantallas.pantalla.*

//lleva la cuenta de que pantalla se esta mostrando (inicio, reglas o game over) y le pasa el ENTER
object gestorPantallas {
    var pantallaActual = sinPantalla

    method mostrar(pantalla) {
        self.ocultarActual()
        pantallaActual = pantalla
        pantalla.mostrar()
    }

    method ocultarActual() {
        pantallaActual.ocultar()
        pantallaActual = sinPantalla
    }

    method accionarEnter() {
        pantallaActual.accionarEnter()
    }
}
