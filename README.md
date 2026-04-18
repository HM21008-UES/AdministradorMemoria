## Simulador Avanzado de Gestión de Memoria en Pseudocódigo

## Integrantes
- Johanna Annelisse López Escobar - LE25007
- Marco Josue Orellana Cortez - OC23006
- Raquel Abigail Hernández Martínez - HM21008

## Descripción del proyecto
Este proyecto consiste en la simulación de una Unidad de Administración de Memoria (MMU) utilizando pseudocódigo en PSeInt. El sistema modela la gestión de memoria mediante páginas, marcos y algoritmos de reemplazo.

El simulador incluye:
- Memoria RAM con 4 marcos
- Traducción de direcciones lógicas a físicas
- Detección de fallos de página
- Algoritmos de reemplazo FIFO y OPT

## Cómo ejecutar el programa en PSeInt
Para ejecutar correctamente el código en PSeInt se debe realizar la siguiente configuración:

1. Abrir PSeInt  
2. Ir a la opción “Configuración”  
3. Seleccionar en la parte superior : Opciones de lenguaje (Perfiles)...
4. Elegir el modo Flexible
5. Presionar aceptar
   
Este modo es necesario porque permite ejecutar el código sin restricciones estrictas de sintaxis, evitando errores por variaciones en el estilo del pseudocódigo.
Ejecución del programa en PSeInt

Una vez configurado el entorno, se procede a ejecutar el simulador:

1. Ya al haber descomprimido la carpeta del proyecto, en la parte superior presionar Archivo
2. Presionar la opción: Abrir
3. Seleccionar el archivo pcs del proyecto "Simulador Avanzado de Gestión de Memoria.psc"
4. Ejecutar el programa con la tecla F9.

## Funcionamiento general:
El programa se divide en tres fases:

### Fase 1: Mapa de bits 
Se inicializa la memoria simulando los marcos libres y ocupados mediante un arreglo de estado.

### Fase 2: Traducción MMU
Se simula la conversión de una dirección lógica a una dirección física utilizando la fórmula:

Dirección física = (marco * tamaño de marco) + offset

También se simula un fallo de página cuando la página no está en memoria.

### Fase 3: Algoritmos de reemplazo
Se implementan dos algoritmos:

- FIFO: reemplaza la página más antigua en memoria.
- OPT: selecciona la página que tardará más en volver a ser utilizada.

## Análisis comparativo:
- El algoritmo OPT presenta menos fallos de página en comparación con FIFO, ya que toma decisiones basadas en el uso futuro de las páginas.
- FIFO es más simple pero menos eficiente, mientras que OPT es más eficiente en teoría.

## Limitación de OPT:
Aunque OPT es el más eficiente matemáticamente, no puede aplicarse en sistemas reales porque requiere conocer el futuro de las referencias de memoria, lo cual no es posible en un sistema operativo.

## Conclusión:
El simulador permite comprender el funcionamiento básico de la gestión de memoria, así como la diferencia entre algoritmos simples como FIFO y algoritmos óptimos teóricos como OPT.
