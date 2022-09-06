#! /bin/bash

# Una aplicación en el lenguaje de su preferencia que lea los valores del sensor 
# y los almacene cada 10 segundos en un archivo llamado:
# 
# AAAAMMDD_TEMPERATURA.csv
# 
# La primera columna del archivo corresponde a la fecha y hora actual en formato 
# “AAAAMMDD HHMMSS“ (Nota, hay un espacio entre el formato) y la segunda a la 
# temperatura leída desde el sensor

ActualDir=$(pwd)

Time=`date +"%Y%m%d %I%M%S"`
TodayDate=`date +"%Y%m%d"`
FileExt="_TEMPERATURA.csv"
FileTag="$TodayDate$FileExt"
FilePath="$ActualDir/$FileTag"

if [ -f "$FilePath" ]; then
    echo "$FileTag exists, new data will be written."
else 
    echo "$FileTag will be created."
    touch $FileTag
    echo "Date,Temperature" >> $FilePath
fi

ModulePath=/sys/bus/w1/devices/w1_bus_master1/28-3c01f095cb82
Temp=0

if [ $# -eq 1 ]; then
    echo "Iniciando script ..."
fi

while true; do

    Temp=$(cat $ModulePath/temperature)
    NumbOfDigits=${#Temp}
    if [ $# -eq 1 ]; then
        echo "Temperatura actual: $Temp"
    fi

    if [ $NumbOfDigits == "4" ]; then
        echo "$Time,${Temp:0:1}.${Temp:1:3}" >> $FilePath
        if [ $# -eq 1 ]; then
            echo "Write : $Time,${Temp:0:1}.${Temp:1:3}   To : $FilePath"
        fi
    else
        if [ $NumbOfDigits == "5" ]; then
            echo "$Time,${Temp:0:2}.${Temp:2:3}" >> $FilePath
            if [ $# -eq 1 ]; then
                echo "Write : $Time,${Temp:0:2}.${Temp:2:3}   To : $FilePath"
            fi
        else
            if [ $NumbOfDigits == "6" ]; then
                echo "$Time,${Temp:0:3}.${Temp:3:3}" >> $FilePath
                if [ $# -eq 1 ]; then
                    echo "Write : $Time,${Temp:0:3}.${Temp:3:3}   To : $FilePath"
                fi
            else
                if [ $NumbOfDigits <= "3" ]; then
                    echo "$Time,0.${Temp:0:3}" >> $FilePath
                    if [ $# -eq 1 ]; then
                        echo "Write : $Time,0.${Temp:0:3}   To : $FilePath"
                    fi
                else
                    echo "$Time,ERROR"
                    if [ $# -eq 1 ]; then
                        echo "ERROR FORMATO TEMPERATURA"
                        echo "Write : $Time,${Temp:0:1}.${Temp:1:3}   To : $FilePath"
                    fi
                fi
            fi
        fi
    fi

    sleep 10

done
