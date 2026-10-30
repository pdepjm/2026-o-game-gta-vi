import proyectil.*
import efectos.*

class Arma{
    const municionMaxima
    var balasEnCargador = municionMaxima
    const property position = game.origin()
    var cooldown = false
    const cooldownMs
    const danio
    const sonido

    method image()

    method balasEnCargador() = balasEnCargador

    method sePuedeAtravesarPolicia() = true
    method sePuedeAtravesarLadron() = true

    //sin balas se escucha el cargador vacio, con el arma en espera entre disparos no pasa nada
    method disparar(origen, direccion){
        if (self.sinBalas()) { sonidoCargadorVacio.sonar() }
        else if (not cooldown) { self.lanzarProyectil(origen, direccion) }
    }

    method lanzarProyectil(origen, direccion){
        cooldown = true
        balasEnCargador -= 1
        self.iniciarCooldown()
        sonido.sonar()
        const celdaDeDisparo = direccion.siguientePosicion(origen) //dispara una posicion adelante del policia
        const proyectil = new Proyectil(position = celdaDeDisparo, direccion = direccion, danioProyectil = danio)
        proyectil.iniciarMovimiento()
    }

    method sinBalas() = balasEnCargador == 0

    method iniciarCooldown() {
        game.schedule(cooldownMs, { cooldown = false })
      }

    method recargar(){
        balasEnCargador = municionMaxima
        sonidoRecargar.sonar()
      }

    //con un arma equipada la municion se recoge
    method recogerMunicion(municion, policia){
        municion.serRecogidaPor(policia)
      }

    method recibirImpactoDe(proyectil){}

}

class Pistola inherits Arma(municionMaxima = 7, cooldownMs = 1500, danio = 1, sonido = sonidoPistola){
 
  override method image() = "pistola.png"

  override method toString() = "Pistola"

}

class Escopeta inherits Arma(municionMaxima = 2, cooldownMs = 2500, danio = 2, sonido = sonidoEscopeta){

    override method image() = "escopeta.png"

    override method toString() = "Escopeta"

}