///////////////////////////  Marco Josue Orellana Cortez

// FIFO - Simulacion
Funcion fallos <- SimularFIFO(refs, cant) //simula remplazo fifo funcion
	Escribir "FASE 3: FIFO"
	Definir ram, ocupado, fallos, punteroFIFO, i, t, pag, idx, libre Como Entero
	definir hayEspacio Como Logico
	
	Dimension RAM[3], ocupado[3] //simulacion de ram con 3 marcos
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