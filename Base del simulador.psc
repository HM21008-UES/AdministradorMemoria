///////////////////////////  Johanna Annelisse López Escobar

Algoritmo AdministradorMemoria
	
	//Parámetros de la simulación
	Definir tam_marco, cant_refs, i Como Entero
	TAM_MARCO <- 4096
	cant_refs <- 12
	
	Definir referencias Como Entero
	Dimension referencias[12] //arreglo de 12 porciones
	referencias[1] <- 1
	referencias[2] <- 2
	referencias[3] <- 3
	referencias[4] <- 4
	referencias[5] <- 1
	referencias[6] <- 2
	referencias[7] <- 5
	referencias[8] <- 1
	referencias[9] <- 2
	referencias[10] <- 3
	referencias[11] <- 4
	referencias[12] <- 5
	
	Definir marcoOcupado Como Entero
	dimension marcoOcupado[4] //  0 = Marco libre 
	
	Escribir "SIMULADOR MMU - - GESTIÓN DE MEMORIA"
	escribir "       "
	
	// Fase 1: Mapa de bits
	escribir "FASE 1: MAPA DE BITS"
	para i <- 1 Hasta 4 hacer
		marcoOcupado[i] <- 0
	finPara //Simulación de RAM vacia, todos los marcos quedan en 0 osea libre 
	
	Escribir "Mapa de bits (M0..M3): " sin saltar
	Para i <- 1 hasta 4 hacer
		Escribir marcoOcupado[i], " " sin saltar // marcos = 0 0 0 0 == MostrarMapaBits() 
	finpara
	escribir ""
	escribir "" 
	
	// Fase 2: Traducción MMU
	Escribir "FASE 2: TRADUCCIÓN MMU"
	escribir "Solicitud página 2, offset 150"
	Escribir "FALLO DE PÁGINA"
	escribir "Página cargada en marco 1" //No esta en RAM ocurre page fault
	
	Definir dirFisica Como Entero //cualculo e dirección fisica
	dirFisica <- (1 * TAM_MARCO) + 150
	Escribir "Dirección física = ", dirFisica  // marco*tamaño_marco+offset =1 * 4096 + 150	= 4246
	escribir "" 
	
	// Fase 3: Ejecución de algoritmos
	definir fFIFO, fOPT Como Entero //RETO 3 -- .llama las funciones que simulan FIFO Y OPT	
	fFIFO <- SimularFIFO(referencias, cant_refs)
	escribir ""
	Fopt <- SimularOPT(referencias, cant_refs)
	escribir ""
	
	// Resultados y análisis
	Escribir "RESULTADOS"
	escribir "FIFO: ", fFIFO, " fallos"
	Escribir "OPT: ", fOPT, " fallos"
	
	si fOPT < fFIFO Entonces
		escribir "OPT genera menos fallos que FIFO." //R4: comparacion de fallos de pagina
	Sino
		Escribir "FIFO y OPT tuvieron el mismo rendimiento."
	FinSi
	
FinAlgoritmo