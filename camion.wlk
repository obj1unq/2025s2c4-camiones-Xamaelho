import cosas.*

object camion {
	const property cosas = #{} // Si bien un tipo Set no admite repetidos, se pide que no cargue teniendo
	var property estaAccidentado = false

	// ########## SOBRE PESOS #############
	method todosLosPesosSonPares() {
		return cosas.all( { cosa => cosa.tienePesoPar() } )
	
	}
	method hayAlgunoQuePesa(peso) {
		return cosas.any( {cosa => cosa.peso() == peso } )
	}

	method tara() = 1000
	
	method pesoMaximo() = 2500
	
	method pesoTotal() {
    	var totalCosas = 0
    	cosas.forEach( { cosa => totalCosas = totalCosas + cosa.peso() } )
    	return self.tara() + totalCosas
	}

	method estaExcedido() = self.pesoTotal() > self.pesoMaximo()

	method puedeCircularEnRutaDePeligrosidadHasta(peligrosidadMaxima) {
		return (not self.estaExcedido()) && ( #{} == self.cosasQueSuperanPeligrosidad(peligrosidadMaxima) )
	}

	method hayAlgoQuePeseEntre(minimo, maximo) {
		return cosas.any({ cosa => cosa.peso() > minimo && cosa.peso() < maximo }) 
	}

	method loMasPesado() {
		if (cosas.isEmpty()) {
        	self.error("El camion esta vacio, no se puede calcular lo más pesado")
    	}
    	return cosas.max( { cosa => cosa.peso() } )
	}

	method pesosDeTodasLasCosas() = cosas.map({ cosa => cosa.peso() }).asSet()

	// ############### SOBRE PELIGROSIDAD ##################
	method encontrarCosaConPeligrosidad(nivel) {
		return cosas.findOrElse({cosa => cosa.nivelPeligrosidad() == nivel }, {self.error("No se encuentra cosa de ese nivel de peligrosidad") })
	}

	method superaPeligrosidad(cosa, nivelDeReferencia) {
		return cosa.nivelPeligrosidad() > nivelDeReferencia
	}

	method cosasQueSuperanPeligrosidad(nivel) {
		return cosas.filter( { cosa => self.superaPeligrosidad(cosa, nivel)	} )
	}
	method cosasQueSeanMasPeligrosasQue(talCosa) {
		const nivelBuscado = talCosa.nivelPeligrosidad()
    	return cosas.filter( { cosa => self.superaPeligrosidad(cosa, nivelBuscado) } )
	}
	// ############### SOBRE LAS COSAS ###################
	method contieneA(unaCosa) = cosas.contains(unaCosa)
	method totalBultos() {}

	method estaAccidentado(_estaAccidentado) {
		estaAccidentado = _estaAccidentado
		if (estaAccidentado) {
			cosas.forEach( { cosa => cosa.afectarPorAccidente() } )
		}
	}

	// ################# VALIDACIONES ###################
	method validarEstadoCarga(unaCosa, deberiaEstarCargada) {
        if (self.contieneA(unaCosa) != deberiaEstarCargada) {
            if (deberiaEstarCargada) {
                self.error("La cosa no está en el camion")
            } else {
                self.error("La cosa ya está en el camion, no se puede volver a agregar!")
            }
        }
    }

	method validarSiPuedeTransitarEnRuta(camino) {
		if (not camino.puedeTransitar(self) ) {
			self.error("No se puede transitar por el camino indicado.")
		}
	}

	// ################### ACCIONES #####################
	method cargar(unaCosa) {
		self.validarEstadoCarga(unaCosa, false)
        cosas.add(unaCosa)
	}

	method descargar(unaCosa) {
		self.validarEstadoCarga(unaCosa, true)
        cosas.remove(unaCosa)
	}

	method transportar(destino, camino) {
		self.validarSiPuedeTransitarEnRuta(camino)
		cosas.forEach( { 
			cosa => cosa.descargar(cosa)
			destino.colocar(cosa) } )
	}

}

object almacen {
	const property deposito = #{}

	method colocar(cosa) {
		deposito.add(cosa)
	}
}

object ruta9 {
	const property nivelPeligrosidadAceptado = 20

	method puedeTransitar(transporte) = transporte.puedeCircularEnRutaDePeligrosidadHasta(20)
}

object caminosVecinales {
	var property pesoMaximo = 2000
	method puedeTransitar(transporte) = pesoMaximo > transporte.pesoTotal() 

	method pesoMaximo(_pesoMaximo) {
		pesoMaximo = _pesoMaximo
	}
}