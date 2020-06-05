#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#define MEM_SIZE 256
int writeDev(char*);
void readDev(int);

void main(void)
{
    /*
    char buffer[20] = {0};
    int fd = open("/dev/mydev", O_RDWR);
    read(fd, buffer, 20);
    printf("Contenido : %s \n", buffer );
    close(fd);
     */

    char option;
    char buffer[MEM_SIZE];
    int bytes = 0, aux;
    
    do{
        printf("\nMENU\n");
        printf("1-Escribir\n");
        printf("2-Leer\n");
        printf("3-Salir\n");
        printf("Elige una opcion : ");
        scanf(" %c",&option); 
        getc(stdin);
        switch (option)
        {
        case '1':
            printf("Introduce la cadena a escribir : ");
            scanf("%[^\n]", buffer);
            //printf("%s\n", buffer); 
            bytes = writeDev(buffer);
            break;
        
        case '2':
            if(bytes  > 0){
                printf("Desea recuperar lo anterior escrito ? : s/any ");
                scanf(" %c",&option); 
                getc(stdin);
                if(option != 's')
                {
                    printf("Introduce el numero de bytes a leer : ");
                    scanf("%d", &aux);
                    getc(stdin);
                    readDev(aux);
                }else{
                    readDev(bytes);
                }
                
            }else{
                printf("Introduce el numero de bytes a leer : ");
                scanf("%d", &aux);
                getc(stdin);
                readDev(aux);
            }
            break;

        default:
            break;
        }
    }while(option!='3');
}


int writeDev(char *buff)
{
    
    int fd = open("/dev/mydev", O_WRONLY);
    write(fd, buff, strlen(buff)); 
    close(fd);

    printf("Se escribio : %s\n", buff); 
    printf("Con un total de : %d bytes\n", strlen(buff)); 
    return strlen(buff);
}

void readDev(int bytes){
    printf("Leyendo : %d \n", bytes);
    
    char buffer[MEM_SIZE] = {0};
    int fd = open("/dev/mydev", O_RDONLY);
    read(fd, buffer, bytes);
    printf("Contenido : %s \n", buffer );
    close(fd);
    
}