import municion.*

class Arma{
    const municionMaxima   
    var property balasEnCargador = municionMaxima
    const property position
    var cooldown = false
    const cooldownMs
    const danio

method image()

method sePuedeAtravesarPolicia() = true
method sePuedeAtravesarLadron() = true

method disparar(origen, direccion){
    if(not self.puedeDisparar()){throw new DomainException(message = "No se puede disparar")}
      cooldown = true
      balasEnCargador -= 1
      self.iniciarCooldown()
      const celdaDeDisparo = direccion.siguientePosicion(origen) //dispara una posicion adelante del policia
      const proyectil = new Proyectil(position = celdaDeDisparo, direccion = direccion, danioProyectil = danio)
      game.addVisual(proyectil)
      proyectil.iniciarMovimiento()
    
  }

method puedeDisparar() = not cooldown and balasEnCargador > 0

method iniciarCooldown() {
    game.schedule(cooldownMs, { cooldown = false })
  }

method recargar(){
    balasEnCargador = municionMaxima
  }

method recibirImpactoDe(proyectil){}

}

class Pistola inherits Arma(municionMaxima = 7, position = game.at(16, 11), cooldownMs = 1500, danio = 1){
 
  override method image() = "pistola.png"

}

class Escopeta inherits Arma(municionMaxima = 2, position = game.at(16, 10), cooldownMs = 2500, danio = 2){

    override method image() = "escopeta.png"

}