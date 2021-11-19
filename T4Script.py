from os import write
import requests
from bs4 import BeautifulSoup
import csv
import time

def scraping():
    url = "https://realpython.github.io/fake-jobs/"
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "html.parser")
    results = soup.find(id = "ResultsContainer")

    job_elements = results.find_all("div", class_="card-content")
    python_jobs = results.find_all(
        "h2", string=lambda text: "python" in text.lower()
    )
    python_jobs_elements = [
        h2_element.parent.parent.parent for h2_element in python_jobs
    ]
    datosG = []
    for job_element in python_jobs_elements:
        title_element = job_element.find("h2", class_="title")
        comapny_element = job_element.find("h3", class_="company")
        location_element = job_element.find("p", class_="location")
        link_url = job_element.find_all("a")[1]["href"]
        datos = []
        datos.append(comapny_element.text.strip())
        datos.append(location_element.text.strip())
        datos.append(title_element.text.strip())
        datos.append(f"Apply Here: {link_url}")
        datosG.append(datos)

    #Imprimir datos
    for datos in datosG:
        for i in datos:
            print(i)
        print()

    #Crear archivo y escribir los datos
    x = input("Ingresa el nombre del archivo.csv a crear: ")
    with open(x + '.csv', 'w') as file:
        print("Creando Archivo.csv ...")
        time.sleep(2)
        print("     ***Archivo.csv Creado***")
        writer = csv.writer(file, dialect='excel')
        writer.writerows(datosG)

scraping()