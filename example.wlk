class Nave {
  var velocidad = 0
  var direccion = 0
  var combustible = 0

  method acelerar(cuanto){
    velocidad = (velocidad+cuanto).min(10000)
  }
  method desacelerar(cuanto){
    velocidad = (velocidad-cuanto).max(0)
  }
  method irHaciaElSol(){
    direccion = 10
  }
  method escaparDelSol(){
    direccion = -10
  }
  method ponerseParaleloAlSol(){
    direccion = 0
  }
  method acercarseUnPocoAlSol(){
    direccion = (direccion + 1).min(10)
  }
  method AlejarseUnPocoDelSol(){
    direccion = (direccion + 1).max(0)
  }
  
  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method cargarCombustible(cantidad){
    combustible += cantidad
  }

  method descargarCombustible(cantidad){
    combustible = (combustible-cantidad).max(0)
  }

  method estaTranquila() = combustible >= 4000 && velocidad <= 12000

  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method escapar()
  method avisar()

  method tienePocaActividad()

  method estaDeRelajo() = self.estaTranquila() && self.tienePocaActividad()

}

class Baliza inherits Nave {
  var colorBaliza = "verde"
  var cambioDeColor = 0

  method cambiarColorDeBaliza(colorNuevo){
    if (colorBaliza != colorNuevo){
      colorBaliza = colorNuevo
      cambioDeColor +=1
    }
      

  }

  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method estaTranquila() = super() && colorBaliza != "rojo"

  override method escapar(){
    self.irHaciaElSol()
  }

  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }

  override method tienePocaActividad() = cambioDeColor == 0

}

class Pasajeros inherits Nave {
  const pasajeros
  var racionDeComida = 0
  var racionDeBebida = 0
  var comidaServida = 0

  method cargarComida(cantidad){
    racionDeComida += cantidad
  }

  method descargarComida(cantidad){
    racionDeComida -= cantidad
    comidaServida += cantidad
  }

  method cargarBebida(cantidad){
    racionDeBebida += cantidad*pasajeros
  }

  method descargarBebida(cantidad){
    racionDeBebida -= cantidad*pasajeros
  }

  override method prepararViaje(){
    self.cargarComida(4)
    self.cargarBebida(6)
    self.acercarseUnPocoAlSol()
  }

  override method escapar(){
    velocidad = velocidad * 2
  }

  override method avisar(){
    self.descargarComida(pasajeros)
    self.descargarBebida(pasajeros*2)
  }

  override method tienePocaActividad(){
    return comidaServida < 50
  }

}

class Combate inherits Nave {
  const mensajes = []
  var invisible = false
  var misilesDesplegados = false

  method ponerseVisible(){
    invisible = false
  }
  method ponerseInvisible(){
    invisible = true
  }
  method estaInvisible(){
    return invisible
  }

  method desplegarMisiles(){
    misilesDesplegados = true
  }

  method replegarMisiles(){
    misilesDesplegados = false
  }

  method misilesDesplegados(){
    return misilesDesplegados
  }

  method emitirMensaje(mensaje){
    mensajes.add(mensaje)
  }

  method mensajesEmitidos(){
    return mensajes
  }

  method primerMensajeEmitido(){
    return mensajes.first()
  }

  method ultimoMensajeEmitido(){
    return mensajes.last()
  }

  method esEscueta(){
     return mensajes.all({m => m.size() < 30})
  }

  method emitioMensaje(mensaje){
    return mensajes.contains(mensaje)
  }

  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
    self.acelerar(15000)
  }

  override method estaTranquila(){
    return super() && !misilesDesplegados
  }

  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar(){
    self.emitioMensaje("Amenaza recibida")
  }

  override method tienePocaActividad() = true

}

class Hospital inherits Pasajeros {
  var quirofanosPreparados = false

  method prepararQuirofanos(){
    quirofanosPreparados = true
  }

  method estanPreparadosLosQuirofanos(){
    quirofanosPreparados
  }

  override method estaTranquila(){
    return super() && !quirofanosPreparados
  }

  override method recibirAmenaza(){
    super()
    self.prepararQuirofanos()

  }
}

class Sigilosa inherits Combate {
  override method estaTranquila(){
    return super() && self.estaInvisible()
  }

  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}

const naveBalizaOne = new Baliza()

const navePasajerosOne = new Pasajeros(pasajeros = 20)

const naveCombateOne = new Combate()

const naveHospitalOne = new Pasajeros(pasajeros = 40)

const naveSigilosaOne = new Combate()