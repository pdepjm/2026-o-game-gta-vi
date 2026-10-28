import proyectil.*

class Arma{
    const municionMaxima
    var balasEnCargador = municionMaxima
    const property position = game.origin()
    var cooldown = false
    const cooldownMs
    const danio

    method image()

    method balasEnCargador() = balasEnCargador

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

    //con un arma equipada la municion se recoge
    method recogerMunicion(municion, policia){
        municion.serRecogidaPor(policia)
      }

    method recibirImpactoDe(proyectil){}

}

class Pistola inherits Arma(municionMaxima = 7, cooldownMs = 1500, danio = 1){
 
  override method image() = "pistola.png"

  override method toString() = "Pistola"

}

class Escopeta inherits Arma(municionMaxima = 2, cooldownMs = 2500, danio = 2){

    override method image() = "escopeta.png"

    override method toString() = "Escopeta"

}