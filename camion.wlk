import cosas.*

object camion {
	const property cosas = #{} // Si bien un tipo Set no admite repetidos, se pide que no cargue teniendo
	
	method contieneA(unaCosa) = cosas.contains(unaCosa)
	method todosLosPesosSonPares() {
		return cosas.all( { cosa => cosa.tienePesoPar() } )
	}
	method hayAlgunoQuePesa(peso) {
		return cosas.any( {cosa => cosa.peso() == peso } )
	}

	method cargar(unaCosa) {
		self.validarEstadoCarga(unaCosa, false)
        cosas.add(unaCosa)
	}

	method descargar(unaCosa) {
		self.validarEstadoCarga(unaCosa, true)
        cosas.remove(unaCosa)
	}

	method validarEstadoCarga(unaCosa, deberiaEstarCargada) {
        if (self.contieneA(unaCosa) != deberiaEstarCargada) {
            if (deberiaEstarCargada) {
                self.error("La cosa no está en el camion")
            } else {
                self.error("La cosa ya está en el camion, no se puede volver a agregar!")
            }
        }
    }
}