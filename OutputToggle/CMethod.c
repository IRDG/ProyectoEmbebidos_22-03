/* 
 * gcc -o CMethodExe CMethod.c -lbcm2835
*/

#include <bcm2835.h>
#include <stdio.h>

#define OUTPUT_LED RPI_GPIO_P1_11

int main (void)
{
    // Inicializar libreria bcm2835
    if (!bcm2835_init())
    {
        return 1;
    }

    // configurar el pin como salida
    bcm2835_gpio_fsel(OUTPUT_LED,BCM2835_GPIO_FSEL_OUTP);
    
    
    char TrialMode = 0;
    printf("activar modo demostracion? (1 para Si) \n");
    scanf("%c", &TrialMode);

    printf("Codigo en ejecucion");
    printf("...");
    printf("Para detener la ejecucion porfavor presione Ctrl+C");

    if (TrialMode == 1)
    {
        printf("Modo demostracion ACTIVO");
    }
    else
    {
        printf("Modo demostracion INACTIVO");
    }
    
    while(1)
    {
        bcm2835_gpio_write(OUTPUT_LED, HIGH);
        if(TrialMode == 1)
        {
            bcm2835_delay(500);
        }
        bcm2835_gpio_write(OUTPUT_LED, LOW);
        if(TrialMode == 1)
        {
            bcm2835_delay(500);
        }
    }
    bcm2835_close();
    return 0 ;
}
