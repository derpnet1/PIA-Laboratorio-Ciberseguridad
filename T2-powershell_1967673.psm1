function ScanSubred {

    #Determinando gateway
    Write-Host "       Escaneo Subred"
    $subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
    Write-Host "Tu gateway: $subred"

    #Determinando el rango de la subred
    $rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3)
    echo $rango

    Write-Host "***Este proceso puede tardar unos minutos ...***"

    #Se forza a terminar en punto el rango de la subred
    $punto = $rango.EndsWith('.')
        if ( $punto -like "False" )
        {
            $rango = $rango +  '.' 
        }
        
    # Creamos un array con 254 numeros En la variable rango_ip   
    $rango_ip = @(1..254)

    #Validamos los host activos con un ciclo.
    foreach ( $r in $rango_ip )
        {
            $actual = $rango + $r 
            $responde = Test-Connection $actual -Quiet -Count 1 
            if ( $responde -eq "True" )
            {
                Write-Output ""
                Write-Host "Host activo: " -NoNewline; Write-Host $actual -ForegroundColor Green
            }
        }

}


function PuertosEquipo {
    
    #Determinando gateway 
    write-host "Puertos activos en el equipo"
    $subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
    Write-Host "== Determinado tu gateway ..."
    Write-Host "Tu gateway es: $subred"

    #Determinando el rango de la subred
    $rango = $subred.Substring(0,$subred.IndexOf(".") + 1 + $subred.Substring($subred.IndexOf(".") +1).IndexOf(".") +3)
    write-host "== Determinado tu rango de subred ..."
    echo $rango

    #Se forza a terminar en punto el rango de la subred
    $punto = $rango.endswith(".")
    if ($punto -like "false"){
        $rango = $rango + "."
    }

    #Definimos un array con los puertos a escanear y se establece una variable waittime
    $portstoscan = @(20,21,22,23,25,50,53,80,110,119,135,136,137,138,143,161,162,389,443,636,1025,1443,3389,5985,5986,8080,10000)
    $waittime = 100

    #Se solicita la direccion IP a escanear
    Write-Host "Direccion ip a escanear: " -NoNewline
    $direccion = Read-Host
    Write-Host "***Este proceso puede tardar ...***"

    #Evaluamos cada puerto del array $portstoscan con un ciclo.
    foreach ($p in $portstoscan){
        $TCPObject = New-Object System.Net.Sockets.TcpClient
            try{$resultado = $TCPObject.ConnectAsync($direccion,$p).Wait($waittime)}catch{}
            if ($resultado -eq "True"){
                Write-Host "Puerto abierto: " -NoNewline; Write-Host $p -ForegroundColor Green
            }
    }
}


function PuertosRedx {
   
    Write-Host "Puertos activos en la red"
    #Determinando gateway
    $subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
    Write-Host "==Determinando tu gateway..."
    Write-Host "Tu gateway: $subred"

    #Determinando el rango de la subred
    $rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3)
    Write-Host "Determinando tu rango de subred..."
    echo $rango
    
    Write-Host "***Este proceso puede tardar unos minutos ...***"
    
    #Se forza a terminar en punto el rango de la subred
    $punto = $rango.EndsWith('.')
    if ( $punto -like "False" )
    {
        $rango = $rango +  '.' 
    }
 
    $rango_ip = @(1..254)
    
    #Validamos los puertos activos en la red con el ciclo foreach.
    Write-Output ""
    Write-Host "-- Subred actual:"
    Write-Host "Escaneando: " -NoNewline ; Write-Host $rango -NoNewline; Write-Host "0/24" -ForegroundColor Red
    Write-Output ""
    foreach ( $r in $rango_ip )
    {
        $actual = $rango + $r 
        $responde = Test-Connection $actual -Quiet -Count 1 
        if ( $responde -eq "True" )
        {
            Write-Output ""
            Write-Host "Puerto responde: " -NoNewline; Write-Host $actual -ForegroundColor Green
        }
    }
}