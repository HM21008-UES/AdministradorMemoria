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

///////////////////////////  Marco Josue Orellana Cortez

// FIFO - Simulación
Funcion fallos <- SimularFIFO(refs, cant) //simula remplazo fifo función
	Escribir "FASE 3: FIFO"
	Definir ram, ocupado, fallos, punteroFIFO, i, t, pag, idx, libre Como Entero
	definir hayEspacio Como Logico
	
	Dimension RAM[3], ocupado[3] //simulación de ram con 3 marcos
	Para i <- 1 Hasta 3 Hacer
		ram[i] <- -1     // incio de ram vacia  -1 no hay pagina cargada 0 marco libre
		ocupado[i] <- 0   
	finpara
	
	Fallos <- 0 //page fault 
	punteroFIFO <- 1   //apunta el marco que sera reemplazado
	
	para t <- 1 Hasta cant hacer  //toma cada pagina solicitada
		pag <- refs[t]
		idx <- -1
		
		para i <- 1 Hasta 3 hacer
			si ocupado[i] = 1 Y RAM[i] = pag entonces  //busqueda si esa en ram
				idx <- i
			finSi
		finpara
		
		si idx = -1 entonces
			fallos <- fallos + 1  //si no esta fallo de pagina
			hayEspacio <- Falso
			libre <- -1
			
			para i <- 1 Hasta 3 hacer
				si ocupado[i] = 0 y hayEspacio = Falso entonces
					libre <- i
					hayEspacio <- verdadero
				finSi
			finpara
			
			si libre <> -1 entonces
				ram[libre] <- pag  // si hay espacio se cargara la pagina  - pagina x: fallo
				ocupado[libre] <- 1
				Escribir "Página ", pag, ": fallo"
			sino
				Escribir "Página ", pag, ": reemplazo FIFO"
				ram[punteroFIFO] <- pag
				punteroFIFO <- punteroFIFO + 1
				si punteroFIFO > 3 entonces
					punteroFIFO <- 1
				finSi
			finSi
		finSi
	finPara
FinFuncion

///////////////////////////  Raquel Abigail Hernández Martínez

// OPT - Elegir víctima (selecciona la página que tardará más en volver a usarse)
Funcion victima <- ElegirVictimaOPT(tActual, RAM, refs, cant)  
	Definir mayorDist, mejorMarco, dist, pagActual, i, k Como Entero 
	
	mayorDist <- -1
	mejorMarco <- 1
	
	Para i <- 1 Hasta 3 Hacer // revisa cada marco de la RAM
		pagActual <- RAM[i]
		dist <- 999 // valor inicial alto (no encontrada aún)
		
		Para k <- tActual + 1 Hasta cant Hacer // busca próxima aparición de la página
			si refs[k] = pagActual y dist = 999 entonces
				dist <- k
			FinSi
		FinPara
		
		si dist > mayorDist entonces // selecciona la página más lejana en el futuro
			mayorDist <- dist
			mejorMarco <- i
		FinSi
	FinPara
	
	victima <- mejorMarco
FinFuncion


// OPT - Simulación del algoritmo de reemplazo ÓPTIMO
Funcion fallos <- SimularOPT(refs, cant) // devuelve número total de fallos de página
	Escribir "FASE 3: OPT"
	
	definir ram, ocupado, fallos, i, t, pag, idx, v, libre Como Entero
	definir hayEspacio como Logico
	
	Dimension RAM[3], ocupado[3]
	
	Para i <- 1 Hasta 3 Hacer
		ram[i] <- -1      // inicializa RAM vacía
		ocupado[i] <- 0   // todos los marcos libres
	FinPara
	
	fallos <- 0
	
	Para t <- 1 Hasta cant Hacer // recorre toda la secuencia de referencias
		pag <- refs[t]
		idx <- -1
		
		Para i <- 1 Hasta 3 Hacer
			si ocupado[i] = 1 y RAM[i] = pag entonces // verifica si la página ya está en RAM
				idx <- i
			FinSi
		FinPara
		
		si idx = -1 entonces // ocurre fallo de página
			fallos <- fallos + 1
			hayEspacio <- Falso
			libre <- -1
			
			Para i <- 1 Hasta 3 Hacer // busca un marco libre
				si ocupado[i] = 0 y hayEspacio = falso entonces
					libre <- i
					hayEspacio <- verdadero
				FinSi
			FinPara
			
			si libre <> -1 entonces
				RAM[libre] <- pag
				ocupado[libre] <- 1
				Escribir "Página ", pag, ": fallo"
			sino
				Escribir "Página ", pag, ": reemplazo OPT"
				v <- ElegirVictimaOPT(t, RAM, refs, cant) // selecciona víctima óptima
				RAM[v] <- pag
			FinSi
		FinSi
	FinPara
FinFuncion