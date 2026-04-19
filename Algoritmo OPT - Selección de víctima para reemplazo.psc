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