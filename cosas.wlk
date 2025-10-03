// ################ COSAS DE LOS PUNTOS INICIALES ###############
object knightRider {
	var property peso = 500
	
	method peso() { return peso }
	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() = (self.peso() % 2) == 0
	method bultosQueRequiere() = 1


	method peso(_peso) {
		peso = 500
	}

	method afectarPorAccidente() {	}
}

object arenaAGranel {
	var property peso = 0

	method peso() { return peso }
	method nivelPeligrosidad() { return 1 }
	method tienePesoPar() = (self.peso() % 2) == 0
	method bultosQueRequiere() = 1

	method peso(_peso) {
		peso = _peso
	}

	method afectarPorAccidente() {
		peso = peso + 20
	}
}

object bumblebee {
	var property peso = 800
	var property transformacion = transformacionAuto

	method nivelPeligrosidad() = transformacion.peligrosidad() 
	method tienePesoPar() = (self.peso() % 2) == 0
	method bultosQueRequiere() = 2
	method transformacion() = transformacion

	method peso(_peso) {
		peso = 800
	}

	method transformacion(_transformacion) {
		transformacion = _transformacion
	}

	method tieneTransformacion(tipoTransformacion) = transformacion == tipoTransformacion

	method afectarPorAccidentePorAccidente() {
        transformacion = if ( self.tieneTransformacion(transformacionAuto) ) {
                transformacionRobot 
            } else { 
                transformacionAuto 
            }
    }
}

object paqueteDeLadrillos {
	var property cantLadrillos = 0

	method peso() { return cantLadrillos * 2 }
	method nivelPeligrosidad() { return 2 }
	method tienePesoPar() = (self.peso() % 2) == 0
	method bultosQueRequiere() {
		var bultos = 1
		if (cantLadrillos > 100 && cantLadrillos <= 300) {
			bultos = 2
		} else {
			bultos = 3
		}
		return bultos
	}

	method cantLadrillos(_cantLadrillos) {
		cantLadrillos = _cantLadrillos
	}

	method afectarPorAccidente(_afectarPorAccidente) {
		cantLadrillos = if (self.cantLadrillos() > 12) {
			cantLadrillos = cantLadrillos - 12
		} else {
			cantLadrillos = 0
		}
	}
}

object bateriaAntiaerea {
	var property tieneMisiles = false

	method tienePesoPar() = (self.peso() % 2) == 0

	method peso() { 
		var peso = 200
		if (tieneMisiles) {
			peso = 300
		}
		return peso
	}

	method nivelPeligrosidad() { 
		var nivel = 0
		if (tieneMisiles) {
			nivel = 100
		}
		return nivel
	 }

	method bultosQueRequiere() {
		var bultos = 1
		if (tieneMisiles) {
			bultos = 2
		}
		return bultos
	}

	method tieneMisiles(_tieneMisiles) {
		tieneMisiles = _tieneMisiles
	}

	method afectarPorAccidente() {
		tieneMisiles = false
	}
}

object residuosRadiactivos {
	var property peso = 0

	method peso() { return peso }
	method nivelPeligrosidad() { return 200 }
	method tienePesoPar() = (self.peso() % 2) == 0
	method bultosQueRequiere() = 1

	method peso(_peso) {
		peso = _peso
	}

	method afectarPorAccidente() {
		peso = peso + 15
	}
}

object transformacionAuto {
	method peligrosidad() = 15
}

object transformacionRobot {
	method peligrosidad() = 30
}

// ################## COSAS DE PUNTOS POSTERIORES ##################
object contenedorProntuario {
	const property cosas = #{}
	
	method peso() { 
		var pesoContenido = 0
		cosas.forEach({cosa => pesoContenido = pesoContenido + cosa.peso() } )
		return 100 + pesoContenido
	}

	method nivelPeligrosidad() { 
		var peligrosidad = 0
		if (not cosas.isEmpty()) {
			const peligrosidades = cosas.map( {cosa => cosa.nivelPeligrosidad() } )
			peligrosidad = peligrosidades.max()
		}
		return peligrosidad
	}

	method tienePesoPar() = (self.peso() % 2) == 0

	method bultosQueRequiere() {
		var bultos = 0
		cosas.forEach( {cosa => bultos = bultos + cosa.bultosQueRequiere() } )
		return bultos + 1
	}

	method cargar(unaCosa) {
        cosas.add(unaCosa)
	}

	method descargar(unaCosa) {
        cosas.remove(unaCosa)
	}

	method afectarPorAccidente() {
		cosas.forEach( { cosa => cosa.afectarPorAccidente() } )
	}
	
}

object embalajeSeguridad {
	var property paquete = envolturaVacia
	
	method peso() { return paquete.peso() }
	method nivelPeligrosidad() { return paquete.nivelPeligrosidad() / 2 }
	method tienePesoPar() = (self.peso() % 2) == 0
	method bultosQueRequiere() = 2

	method empaquetar(unaCosa) {
		paquete = unaCosa
	}
	method desempaquetar() {
		paquete = envolturaVacia
	}

	method afectarPorAccidente() {	}
}

object envolturaVacia {

	method peso() { return 0 }
	method nivelPeligrosidad() { return 0 }
	method tienePesoPar() = (self.peso() % 2) == 0

}