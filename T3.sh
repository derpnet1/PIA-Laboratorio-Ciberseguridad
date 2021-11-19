#!/bin/bash

function info(){
	echo "++Informacion del Equipo++"
	echo "	Username: "${LOGNAME}
	echo "	Hostname: "${HOSTNAME}
	if type -t wevtutil &> /dev/null
	then 
		OS=WSWin
	elif type -t scutil &> /dev/null
	then 
		OS=macOS
	else
		OS=Linux
	fi
	echo "	El sistema operativo es: "$OS
}

function portscan(){
	echo "++Escaneo de los puertos++"
	ip=`ifconfig|grep inet|grep -v "127.0.0.1"|grep -v "::1"|grep -v "fe80::a00:27ff:fec8:365b"|awk '{print $2}'`
	echo "	La direccion ip es: "$ip
	echo "	Generando archivo de resultados..."
	sleep 2
	echo "	Archivo Completado."
	echo "		Name:portscan.txt"
	echo "	Mostrando Puertos activos..."
	sleep 2
	nc -nvz $ip 1-1024 > portscan.txt 2>&1
		cat portscan.txt
}

function netscan(){
	which ifconfig && { echo "++Comando ifconfig existe...++";
			direccion_ip=`ifconfig |grep inet |grep -v "127.0.0.1"|grep -v "fe80::a00:27ff:fec8:365b"|grep -v "::1"|awk '{ print $2}'`;
			echo "	Esta es tu direccion ip: "$direccion_ip;
			subred=`ifconfig |grep inet|grep -v "127.0.0.1"|awk '{print $2}'|grep -v "fe80::a00:27ff:fec8:365b"|grep -v "::1"|awk -F. '{print $1"."$2"."$3"."}'`;
			echo "	Esta es tu subred: "$subred;
		}\
			|| { echo "++No existe el comando ifconfig...usando ip++ ";
			direccion_ip=`ip addr show |grep inet |grep -v "127.0.0.1"|grep -v "fe80::a00:27ff:fec8:365b"|grep -v "::1"|awk '{print $2}'`;
			echo "	Esta es tu direccion ip: "$direccion_id;
			subred=`ip addr show |grep inet |grep -v "127.0.0.1" |awk '{print $2}'|grep -v "fe80::a00:27ff:fec8:365b"|grep -v "::1"|awk -F. '{print $1"."$2"."$3"."}'`;
			echo "	Esta es tu subred: "$subred;
		}
	
	echo "	Host Activos: "
	echo "	Este proceso puede tardar unos minutos..."
	for ip in {1..100}
	do 
		ping -c 1 ${subred}${ip} > /dev/null
		[ $? -eq 0 ] && echo "	  Host responde: "${subred}${ip}
	done
	for ip in {100..200}
	do 
		ping -c 1 ${subred}${ip} > /dev/null
		[ $? -eq 0 ] && echo "	  Host responde: "${subred}${ip}
	done
	for ip in {200..254}
	do
		ping -c 1 ${subred}${ip} > /dev/null
		[ $? -eq 0 ] && echo "	  Host responde: "${subred}${ip}
	done
}	

#menu
x=0
echo "La fecha de hoy es: $(date)"
while [ $x -ne 4 ]
do
	echo ""
	echo "==MENÚ=="
	echo "1.-Escaneo de equipos activos en la red."
	echo "2.-Escaneo de puertos activos en el equipo."
	echo "3.-Informacion del equipo."
	echo "4.-Salir"
	read -p "Ingresa una opcion: " x
	
	case $x in
		1) netscan ;;
		2) portscan ;;
		3) info ;;
		4) echo "Adios :)" ;;
		*) echo "ERROR...Opcion no valida"
			x=0 ;;
	esac
done



