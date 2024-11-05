#!/bin/bash

#Archivo de salida
archivo="monitoreo.txt"
printf "%-10s %-20s %-15s %-15s\n" "Tiempo" "% Total de CPU Libre" "% Memoria Libre" "% Disco Libre"> $archivo

#Captura de datos cada 60 segundos durante 5 minutos (5 iteraciones)
for i in {1..5}; do
	#Tiempo actual
	tiempo="$((i*60))s"
	#Porcentaje de CPU libre
	cpulibre=$(top -b -n1 | grep "Cpu(s)" | awk '{print 100 - $2}'| awk -F. '{print $1}')
	#Porcentaje de memoria libre
	memlibre=$(free | grep Mem | awk '{print $4/$2 * 100.0}' | awk -F. '{print $1}')
	#Porcentaje de disco libre (usar la particion raiz /)
	discolibre=$(df -h / | grep '/' | awk '{print $5}' | tr -d '%')
	#Mostrar los resultados en la terminal
	echo "Tiempo: $tiempo | %Totak de CPU libre: $cpulibre | %Memoria Libre: $memlibre |%Disco libre: $discolibre" 
	#Imprimir los resultados en formato de tabla
	printf "%-10s %-20s %-15s %15s\n" "$tiempo" "$cpulibre" "$memlibre" "$discolibre">> $archivo
	#Esperar 60 segundos antes de la proxima iteracion
	sleep 60
done

echo "Monitoreo completado.Lso resultados se guardaron en $archivo"

