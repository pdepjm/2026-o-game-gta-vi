import proyectil.*
import efectos.*
import mapa.*

class Arma{
    const municionMaxima
    var balasEnCargador = municionMaxima
    const property position = game.origin()
    var cooldown = false
    const cooldownMs
    const danio
    const sonido
    const tiempoReaparicionMs = 30000

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

    //cuando el policia la toma, vuelve a aparecer otra igual despues de un tiempo
    method alSerTomada(){
        game.schedule(tiempoReaparicionMs, { mapa.reaparecerArma(self) })
    }

    //el arma que reaparece otra igual en la misma celda
    method nuevaEnLaMismaCelda()

    method recibirImpactoDe(proyectil){}

}

class Pistola inherits Arma(municionMaxima = 7, cooldownMs = 1500, danio = 1, sonido = sonidoPistola){
 
  override method image() = "pistola.png"

  override method toString() = "Pistola"

  override method nuevaEnLaMismaCelda() = new Pistola(position = position)

}

class Escopeta inherits Arma(municionMaxima = 2, cooldownMs = 2500, danio = 2, sonido = sonidoEscopeta){

    override method image() = "escopeta.png"

    override method toString() = "Escopeta"

    override method nuevaEnLaMismaCelda() = new Escopeta(position = position)

}