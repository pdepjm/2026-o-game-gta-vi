//lo que se muestra en el tablero (personajes, dinero, armas, municiones, camion y proyectiles) entiende todos los mismos mensajes
//por defecto se puede atravesar, no le pasa nada si le disparan y no hace nada cuando alguien llega a su celda
//cada uno redefine solo lo que le cambia
class ElementoDelTablero {
    method sePuedeAtravesarLadron() = true
    method sePuedeAtravesarPolicia() = true

    method recibirImpactoDe(proyectil) {}

    //se llama cuando un personaje termina de moverse a la celda donde esta este elemento
    method reaccionarAlLlegar(quienLlego) {}
}
