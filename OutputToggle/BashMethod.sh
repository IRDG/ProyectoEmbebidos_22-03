#! /bin/bash

raspi-gpio set 17 op
raspi-gpio set 17 dl
echo "Script en ejecucion"
echo "...."
echo "Para detener la ejecucion porfavor presione Ctrl+C"
if [ $# -eq 1 ]; then
    echo "Modo demostracion ACTIVO"
else
    echo "Modo demostracion INACTIVO"
fi

while true
do
    raspi-gpio set 17 dh
    if [ $# -eq 1 ]; then
        sleep 1
    fi
    raspi-gpio set 17 dl
    if [ $# -eq 1 ]; then
        sleep 1
    fi
done
