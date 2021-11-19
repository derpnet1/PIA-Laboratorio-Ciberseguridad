#Laboratorio de ciberseguridad.
#Tarea 2 powershell .
#Escaneo de subred, puertos del equipo y puertos activos en la red.

#Elaborado por: Daniel Ernesto Rangel Perez .
#Matricual: 1967673 
#Fecha: 15/10/2021


#Importamos nuestro modulo en la direccion de modulos de powershell pero en un carpeta creada llamada Tarea.
Import-Module "C:\Program Files\WindowsPowerShell\Modules\Tarea\T2-powershell_1967673.psm1"

#Con la variable $a se abre un ciclo repetitivo para mostrar y solicitar nuestra opcion a ejecutar. 
$a = 0
while($a -eq 0){
 $opc = Read-Host "
        
        Menu:
 [1]-Escaneo de Subred
 [2]-Escaneo de puertos para un equipo
 [3]-Escaneo de puertos para todos los equipos que estén activos en la red
 [0]-Salir

 Elige una opcion"
 
  switch($opc){
    1{
        write-host ""
        ScanSubred
        Write-Host "*********************************************"
        break
    }
    2{
        write-host ""
        PuertosEquipo
        Write-Host "*********************************************"
        break
    }
    3{
        write-host ""
        PuertosRedx
        Write-Host "*********************************************"
        break
    }
    0{
        $a = 1
        Write-Host ""
        Write-Host "Adios :)"
        Write-Host "Produced by: Daniel Ernesto Rangel Perez"
    }
  } 
}
