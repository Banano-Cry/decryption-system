while true
    clc
    fprintf('[+] Bienvenido al sistema de encriptacion/desencriptacion en Matlab [+]\n');
    fprintf('Seleccione la accion a realizar:\n');
    fprintf('1)Encriptar\n');
    fprintf('2)Desencriptar\n');
    fprintf('3)Salir del programa\n');
    respuesta = input('Acccion a realizar: ');
    switch respuesta
        case 1
            clc
            fprintf('[+]Tipos de encriptacion[+]\n1) Encriptado Cesar\n2) Encriptado Aleatorio\n3) Volver al menu\n');
            answer = input('Seleccione un encriptado escribiendo el numero que le antecede: ');
            switch answer
                case 1
                    clc
                    fprintf('[+]Encriptado Cesar seleccionado...\n');
                    desplazamiento = input('[+]Escribir cuantas casillas se va a desplazar cada letra: ');
                    [tipo, escrito] = seleccionModo();
                    [clave, encriptado] = encriptadoCesar(escrito,desplazamiento);
                    fprintf('[+]La llave y el mensaje encriptado se guardaran en archivos aparte...\n');
                    ArchivoMensaje = input('Como se llamara el archivo que contenga el mensaje encriptado: ','s');
                    ArchivoClave = input('Como se llamara el archivo que contenga la llave: ','s');
                    finalizado = guardarDatos(encriptado,clave,ArchivoMensaje,ArchivoClave);
                    if finalizado == 1
                        fprintf('[+]Se ha guardado la informacion de forma correcta...');
                    else
                        fprintf('[-]Ha habido un problema al escribir la informacion...');
                    end
                    pause(3)
                case 2
                    clc
                    fprintf('[+]Encriptado aleatorio seleccionado...\n');
                    [tipo, escrito] = seleccionModo();
                    [clave, encriptado] = encriptadoAleatorio(escrito);
                    fprintf('[+]La llave y el mensaje encriptado se guardaran en archivos aparte...\n');
                    ArchivoMensaje = input('Como se llamara el archivo que contenga el mensaje encriptado: ','s');
                    ArchivoClave = input('Como se llamara el archivo que contenga la llave: ','s');
                    finalizado = guardarDatos(encriptado,clave,ArchivoMensaje,ArchivoClave);
                    if finalizado == 1
                        fprintf('[+]Se ha guardado la informacion de forma correcta...');
                    else
                        fprintf('[-]Ha habido un problema al escribir la informacion...');
                    end
                    pause(3);
                case 3
                    break;
            end
        case 2
            clc
            fprintf('[+]Tipos de desencriptacion[+]\n1) Desencriptado Cesar\n2) Desencriptado Aleatorio\n3) Volver al menu\n');
            answer = input('Seleccione un desencriptado escribiendo el numero que le antecede: ');
            switch answer
                case 1
                    clc
                    fprintf('[+]Desencriptado Cesar seleccionado...\n');
                    ArchivoMensaje = input('Como se llama el archivo que contiene el mensaje encriptado: ','s');
                    ArchivoClave = input('Como se llama el archivo que contiene la clave: ','s');
                    desencriptado = desencriptadoCesar(ArchivoMensaje,ArchivoClave);
                    fprintf('[+] Desencriptado correctamente!!\n');
                    fprintf('El mensaje desencriptado se almacenara en un archivo...\n');
                    nombreArchivo = input('Como se llamara el arcihvo desencriptado: ','s');
                    Finalizado = guardarDatosDesCesar(nombreArchivo,desencriptado);
                    if finalizado == 1
                        fprintf('[+]Se ha guardado la informacion de forma correcta...');
                    else
                        fprintf('[-]Ha habido un problema al escribir la informacion...');
                    end
                    pause(3);
                case 2
                    clc
                    fprintf('[+]Desencriptado aleatorio seleccionado...\n');
                    ArchivoMensaje = input('Como se llama el archivo que contiene el mensaje encriptado: ','s');
                    ArchivoClave = input('Como se llama el archivo que contiene la clave: ','s');
                    desencriptado = desencriptadoAleatorio(ArchivoMensaje, ArchivoClave);
                    fprintf('[+] Desencriptado correctamente!!\n');
                    fprintf('El mensaje desencriptado se almacenara en un archivo...\n');
                    nombreArchivo = input('Como se llamara el arcihvo desencriptado: ','s');
                    Finalizado = guardarDatosDesCesar(nombreArchivo,desencriptado);
                    if finalizado == 1
                        fprintf('[+]Se ha guardado la informacion de forma correcta...');
                    else
                        fprintf('[-]Ha habido un problema al escribir la informacion...');
                    end
                    pause(3);
                case 3
                    break;
            end
        case 3
            fprintf('Saliendo del programa...\n');
            break
     end
end
function [tipo, escrito] = seleccionModo()
clc
    while true
        fprintf('[+]Desea escribir el mensaje o leerlo de un documento:\n');
        fprintf('1) Escribir el mensaje\n');
        fprintf('2) Leer un documento\n');
        tipo = input('Opcion: ');
        switch tipo
            case 1
                escrito = input('Escriba el mensaje: ', 's')
                break;
            case 2
                archivo = input('Escriba el nombre del archivo: ','s');
                file = fopen(archivo,'r');
                escrito = fscanf(file,'%c');
                fclose(file);
                break;
            otherwise
                fprintf('Favor escribir una opcion valida...\n');
        end
    end
end

function [clave, encriptado] = encriptadoCesar(mensaje, desplazamiento)
    cadena = 'abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWYXZ .,';
    encriptado = '';
    clave = desplazamiento;
    escrito = mensaje;
    for letra = escrito
        nuevaLetra = strfind(cadena,letra) + desplazamiento;
        if nuevaLetra > 57
            while nuevaLetra > 57
                nuevaLetra = nuevaLetra - 57;
            end
            encriptado(end + 1) = cadena(nuevaLetra);
        elseif numel(nuevaLetra) == 0
            encriptado(end + 1) = ';';
        else
            encriptado(end + 1) = cadena(nuevaLetra);
        end
    end
end

function [desencriptado] = desencriptadoCesar(archivoMensaje,archivoClave)
    file = fopen(archivoMensaje,'r');
    mensaje = fscanf(file,'%c');
    fclose(file);
    file = fopen(archivoClave,'r');
    clave = fscanf(file,'%i');
    fclose(file);
    cadena = 'abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWYXZ .,';
    desencriptado = '';
    for letra = mensaje
        nuevaLetra = strfind(cadena,letra) - clave;
        if nuevaLetra <= 0
            while nuevaLetra <= 0
                nuevaLetra = nuevaLetra + 57;
            end
            desencriptado(end + 1) = cadena(nuevaLetra);
        elseif numel(nuevaLetra) == 0
            desencriptado(end + 1) = ' ';
        else
            desencriptado(end + 1) = cadena(nuevaLetra);
        end
    end
end

function [clave, encriptado] = encriptadoAleatorio(mensaje)
    permutacion = randperm(length(mensaje));
    columna = [permutacion',[1:1:length(mensaje)]'];
    clave = columna(:,1);
    encriptado=mensaje(clave);
    clave = sortrows(columna)
    clave = clave(:,2)
end

function [desencriptado] = desencriptadoAleatorio(archivoMensaje, archivoClave)
    file = fopen(archivoMensaje,'r');
    mensaje = fscanf(file,'%c');
    fclose(file);
    file = fopen(archivoClave,'r');
    clave = fscanf(file,'%i\n');
    fclose(file);
    desencriptado = mensaje(clave)
end

function Finalizado = guardarDatos(mensaje,clave,nombreArchivoMensaje,nombreArchivoClave)
    archivoMensaje = fopen(nombreArchivoMensaje, 'w');
    fprintf(archivoMensaje,'%c',mensaje);
    fclose(archivoMensaje);
    archivoClave = fopen(nombreArchivoClave,'w');
    fprintf(archivoClave,'%i\n',clave);
    fclose(archivoClave);
    Finalizado = 1;
end

function Finalizado = guardarDatosDesCesar(nombreArchivo,desencriptado)
    file = fopen(nombreArchivo, 'w');
    fprintf(file,'%c',desencriptado);
    fclose(file);
    Finalizado = 1;
end