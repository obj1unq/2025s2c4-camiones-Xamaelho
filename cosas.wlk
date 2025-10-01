object knightRider {
	var property peso = 500
	
	method peso() { return peso }
	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() = (self.peso() % 2) == 0

	method peso(_peso) {
		peso = 500
	}
}

object arenaAGranel {
	var property peso = 0

	method peso() { return peso }
	method nivelPeligrosidad() { return 1 }
	method tienePesoPar() = (self.peso() % 2) == 0

	method peso(_peso) {
		peso = _peso
	}
}

object bumblebee {
	var property peso = 800
	var property transformacion = transformacionAuto

	method peso() { return peso }
	method nivelPeligrosidad() { return transformacion.peligrosidad() }
	method tienePesoPar() = (self.peso() % 2) == 0

	method peso(_peso) {
		peso = _peso
	}
}

object paqueteDeLadrillos {
	var property cantLadrillos = 0

	method peso() { return cantLadrillos * 2 }
	method nivelPeligrosidad() { return 2 }
	method tienePesoPar() = (self.peso() % 2) == 0

	method cantLadrillos(_cantLadrillos) {
		cantLadrillos = _cantLadrillos
	}
}

object bateriaAntiaerea {
	var property tieneMisiles = false

	method tienePesoPar() = (self.peso() % 2) == 0

	method peso() { 
		if (tieneMisiles) {
			return 300
		} else {
			return 200
		}
	}

	method nivelPeligrosidad() { 
		if (tieneMisiles) {
			return 100
		} else {
			return 0
		}
	 }

	method tieneMisiles(_tieneMisiles) {
		tieneMisiles = _tieneMisiles
	}
}

object residuosRadiactivos {
	var property peso = 0
	method peso() { return peso }
	method nivelPeligrosidad() { return 200 }
	method tienePesoPar() = (self.peso() % 2) == 0

	method peso(_peso) {
		peso = _peso
	}
}

object transformacionAuto {
	method peligrosidad() = 15
}

object transformacionRobot {
	method peligrosidad() = 30
}