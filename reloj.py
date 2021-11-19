# Importamos el módulo Tkinter 
from tkinter import * 
from tkinter.ttk import *
from time import strftime 
  
root = Tk() 
root.title('Reloj-Tarea8-1967673') 

def hora(): 
    
  
    datos = strftime('%I:%M:%S %p') 
    label.config(text = datos) 
    label.after(1000, hora) 
  
 
label = Label(root, 
	font = (
		'MV Boli', 60
	), 
	padding = '50',
    background = 'black', 
    foreground = 'green' 
) 

label.pack(expand = True) 

hora()   
mainloop()
