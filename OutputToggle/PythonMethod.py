#! /bin/python3

#Script para levantar y bajar un pin con Python
#Para probar con led por favor descomente los comando time.sleep()
import RPi.GPIO as gpio
import time

gpio.setmode(gpio.BOARD)
gpio.setup(11, gpio.OUT)

TrialMode = int(input("Activar modo desmostracion? (1 para Si) \n"))

print("Script en ejecucion")
print("...")
print("Para detener la ejecucion porfavor presione Ctrl+C")

if TrialMode == 1:
    print("Modo demostracion ACTIVO")
else:
    print ("Modo demostracion INACTIVO")

while True:
    gpio.output(11, True)
    if TrialMode == 1:
        time.sleep(0.5)
    gpio.output(11, False)
    if TrialMode == 1:
        time.sleep(0.5)
