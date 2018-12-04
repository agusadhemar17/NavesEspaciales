class NaveEspacial {

	var velocidad = 0
	var direccion = 0
	var combustible = 0

	method velocidad(cuanto) {
		velocidad = cuanto
	}

	method acelerar(cuanto) {
		velocidad = (velocidad + cuanto).min(100000)
	}

	method desacelerar(cuanto) {
		velocidad -= cuanto
	}

	method irHaciaElSol() {
		direccion = 10
	}

	method escaparDelSol() {
		direccion = -10
	}

	method ponerseParalelaAlSol() {
		direccion = 0
	}

	method acercarseUnPocoAlSol() {
		direccion = (direccion + 1).min(10)
	}

	method alejarseUnPocoDelSol() {
		direccion = (direccion - 1).min(-10)
	}

	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}

	method cargarCombustible(litros) {
		combustible += litros
	}

	method descargarCombustible(litros) {
		combustible -= litros
	}

	method escapar()

	method avisar()

	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}
	method estaTranquila(){
		return combustible >= 4000 and velocidad <= 12000
		
	}
}

class NaveBaliza inherits NaveEspacial {

	var color = "verde"

	method colorBaliza() {
		return color
	}

	method cambiarColorDeBaliza(nuevoColor) {
		color = nuevoColor
	}

	override method prepararViaje() {
		self.cambiarColorDeBaliza("verde")
		self.ponerseParalelaAlSol()
	}

	override method escapar() {
		self.irHaciaElSol()
	}

	override method avisar() {
		self.cambiarColorDeBaliza("rojo")
	}
	override method estaTranquila(){
		return super() and self.colorBaliza() != "rojo"
	}
}

class NaveDePasajeros inherits NaveEspacial {

	var cantidadPasajeros
	var cantidadRacionesComida
	var cantidadRacionesBebida

	method cargarComida(cantidad) {
		cantidadRacionesComida += cantidad
	}

	method cargarBebida(cantidad) {
		cantidadRacionesBebida += cantidad
	}

	override method prepararViaje() {
		self.cargarComida(4 * cantidadPasajeros)
		self.cargarBebida(6 * cantidadPasajeros)
		self.acercarseUnPocoAlSol()
	}

	override method escapar() {
		velocidad = velocidad * 2
	}

	override method avisar() {
		self.cargarComida(1 * cantidadPasajeros)
		self.cargarBebida(2 * cantidadPasajeros)
	}

}

class NavesDeCombate inherits NaveEspacial {

	var visible = true
	var misilesDesplegados = false
	var mensajes = []

	method ponerseInvisible() {
		visible = false
	}

	method ponerseVisible() {
		visible = true
	}

	method estaInvisible() {
		return visible
	}

	method desplegarMisiles() {
		misilesDesplegados = true
	}

	method replegarMisiles() {
		misilesDesplegados = false
	}

	method misilesDesplegados() {
		return misilesDesplegados
	}

	method emitirMensaje(mensaje) {
		mensajes.add(mensaje)
	}

	method mensajesEmitidos() {
		return mensajes
	}

	method primerMensajeEmitido() {
		return mensajes.first()
	}

	method ultimoMensajeEmitido() {
		return mensajes.last()
	}

	method esEscueta() {
		return mensajes.any({ mensaje => mensaje.size() <= 30 })
	}

	method emitioMensaje(mensaje1) {
		return mensajes.contains(mensaje1)
	}

	override method prepararViaje() {
		super()
		self.acelerar(15000)
		self.ponerseInvisible()
		self.replegarMisiles()
		self.emitirMensaje("Saliendo en Mision")
	}

	override method escapar() {
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}

	override method avisar() {
		self.emitirMensaje("Amenaza Recibida")
	}

override method estaTranquila(){
		return super() and not self.misilesDesplegados()
	}
	}

class NaveHospital inherits NaveDePasajeros{
	var property tieneQuirofanos = false
	override method recibirAmenaza(){
		super()
		tieneQuirofanos = true
	}
	override method estaTranquila(){
		return super() and not self.tieneQuirofanos()
	}
	
}

class NaveCombateSigilosa inherits NavesDeCombate{
	override method escapar(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
	override method estaTranquila(){
		return super() and not self.estaInvisible()
	}
	
}