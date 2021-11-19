import nmap

#se establecen los intervalos de puertos.
x = 1
y = 255 
 
target = '127.0.0.1'
#se establece la funcion del escaneo por medio de python-nmap
scanner = nmap.PortScanner()

for i in range(x,y+1):
    res = scanner.scan(target,str(i))
    
    #res define si el puerto esta abierto o cerrado.
    res = res['scan'][target]['tcp'][i]['state']
    #se condicona para saber si el puerto esta abierto y en ese caso se imprime.
    a = (f'port {i} is {res}.')
    if res == 'open':
        print(a)
