import cosas.*

object camion {
	const property cosas = #{} // Siendo cosas un tipo set, no admite repetidos
	
	method contieneA(unaCosa) = cosas.contains(unaCosa)

	method cargar(unaCosa) {
		// Necesito que no lo tenga
		if (not self.contieneA(unaCosa)) {
			cosas.add(unaCosa)
		} else {
			self.error("La cosa ya está en el camion, no se puede volver a agregar!")
		}
	}

	method descargar(unaCosa) {
		self.validarQueContiene(unaCosa)
		cosas.remove(unaCosa)
	}

	method validarQueContiene(unaCosa) {
		if (not self.contieneA(unaCosa) ) {
			self.error("La cosa no está en el camion")
		}
	}
}
