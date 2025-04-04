# CTF-3
*Capture the flag* donde se trabaja la enumeración y *fingerprinting*, interacciones con formularios e inyecciones *SQL*.
<div>
  <img src="https://img.shields.io/badge/-Kali-5e8ca8?style=for-the-badge&logo=kalilinux&logoColor=white" />
  <img src="https://img.shields.io/badge/-Nmap-6933FF?style=for-the-badge&logo=nmap&logoColor=white" />
  <img src="https://img.shields.io/badge/-Dirbuster-005571?style=for-the-badge&logo=dirbuster&logoColor=white" />
  bash
  inyeccion sql
  SQLMap
  <img src="https://img.shields.io/badge/-Metasploit-2596CD?style=for-the-badge&logo=metasploit&logoColor=white" />
  <img src="https://img.shields.io/badge/-python-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/-steghide-FF5200?style=for-the-badge&logo=steghide&logoColor=white" />
  <img src="https://img.shields.io/badge/-Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
</div>

## Objetivo

Explicar la realización del siguiente _Capture the flag_ dentro del mundo educativo. Se preteneden conseguir dos archivos (_flags_), el cual se encuentra dentro del entorno del usuario básico. Para ello, se deberá penetrar en la máquina, y pasar al usuario básico. En otro repositorio se explicará como a aprtir d esta maquina se podra pivotar hacia otra máquina.

## Que hemos aprendido?

- Realizar fingerprinting y enumeración de puertos y enumeración web (mediante *Dirbuster*).
- Interctuar con formularios
- Inyecciones SQL

## Herramientas utilizadas

- *Kali Linux*.
- Enumeración: *Nmap*, *Dirbuster*.
- Penetración: *Bash*, *SQLMap*. 

## Steps

### Enumeración y fingerprinting

La máquina a vulnerar está desplegada dentro de un *Docker*, en este caso se encuentra corriendo en uno de nuestros puertos. Así pues, **nmap** es lanzado con la IP destino de la máquina anfitriona para buscar en que puerto está corriendo la máquina víctima. Como resultado se descubre el puerto 5000 donde corre un servicio *upnp*, donse se encuentra la máquina.

<code>nmap -p- -Pn -sV 10.0.2.15</code>

![image](https://github.com/user-attachments/assets/614d71a1-2cb7-416e-b7f6-879e8eef422a)

Al acceder a la URL 10.0.2.15:5000 desde el navegador, doy con un mensaje, el cual da a entender que encontraré varias vulnerabilidades por el camino.

![image](https://github.com/user-attachments/assets/14705a54-0122-4f9b-a335-591be1bc76d4)

Para la enumeracion web, se utiliza la herramienta **Dirbuster**, centrando la búsqueda en las extensiones *html, php, bak y tgz*. No se ha encontrado ningún directorio, pero sí el archivo 'backup.php'.

![image](https://github.com/user-attachments/assets/67b5cf8f-9679-4f43-953e-129bca666be0)

### Vulnerabilidades explotadas

Al acceder a la dirección 10.0.2.15:5000/backup.php, encuentro un formulario POST. Este nos pregunta si queremos saber su identidad y nos pide dos números para sumar. Al rellenarlo nos devuelve el resultado y nos desvela el usuario ‘www-data’, por lo que cabe esperar que el servidor sea Apache o incluso Nginx. Si contestamos que no queremos saber la identidad, se muestra un mensaje distinto.

![image](https://github.com/user-attachments/assets/1698f1fc-7adf-4fa3-8a44-0e847bd90ea1)

Es interesante jugar con el formulario para ver que respeustas se obtienen, como dejar los números en blanco, utilizar valores negativos o introducir la clásica sentencia de “’or 1=1” pero no lo interpreta de la manera esperada. De hecho cada vez que se indica un espacio, ya no sabe interpretar lo escrito. Probando comandos como <code>ls</code>, <code>pwd</code>… se obtienen un resultado positivo cuando estos comandos han sido introducidos entre ‘;’, provocando una concatenación de comandos. Así pues, para conocer en que directorio me encuentro y qué contiene, se utiliza la siguiente sentencia dentro del comando ‘Numero 1’.

<code>;pwd;ls;</code>

![image](https://github.com/user-attachments/assets/b5bbc945-8dff-4822-9160-d3baa35a00e3)

Entre los archivos que devuelve el comando se puede ver 'password.php'. Para leer su contenido sólo ha sido necesario utilizar el comando <code>;cat password.php</code> dentro del formulario. Este archivo contiene el código *php* de la lógica del formulario anterior y además, un nuevo formulario GET. Si  se rellena este formuario con posible IDs, se obtienen las siguientes frase.
|ID|Respuesta|
|--|---------|
|0 |no hay mal que por bien no venga|
|1 |luchando contra la adversidad|
|2 |hasta el infinito y mas alla|
|3 |Esto es un TFM con Rock'n'Roll|

Utilizando la sentencia <code>1’ or ‘1’ = ‘1</code> consigo comprobar que es vulnerable a inyecciones SQL, pues me devuelve todas las frases contenidas en la tabla ‘frases’.

![image](https://github.com/user-attachments/assets/409b3355-1c53-4ac5-b877-bbde24a2740a)

Demostrado esto, se hace uso de la herramienta **SQLMap** para buscar que tablas contiene la base de datos y encontrar posible información que sea útil en la búsqueda de la flag.
Se parte de la URL http://10.0.2.15:5000/password.php?id=1 (esta es la dirección a la que se llega cuando indicas en el formulario el ID 1) y se le pasa el parámetro ‘--dbs’ para encontrar las bases de datos contenidas. El parámetro ‘--batch’ se utiliza para que durante la ejecución no esté preguntando por los siguientes pasos a realizar.

<code>sqlmap -u "http://10.0.2.15:5000/password.php?id=1" --dbs --batch</code>

![image](https://github.com/user-attachments/assets/a2896bec-aa3f-4bb7-b88e-7a5b77bcb62d)

De entre las bases de datos devueltas, destaca ‘poc’. Así pues, se indica con ‘-D’ la base de datos a analizar y con ‘--tables’, las tablas pertenecientes a ‘poc’.

<code>sqlmap -u "http://10.0.2.15:5000/password.php?id=1" -D poc --tables --batch</code>

![image](https://github.com/user-attachments/assets/c14f5665-5158-4c59-97e5-473e5239933d)

Primero me centro en la tabla ‘flags’ con el parámetro ‘-T’ y compruebo sus campos con el parámetro ‘--columns’.

<code>sqlmap -u "http://10.0.2.15:5000/password.php?id=1" -D poc -T flags --columns --batch</code>

![image](https://github.com/user-attachments/assets/51a5a702-d35c-4c18-99af-ade32ed000c3)

Ya sólo queda recuperar el contenido de la tabla indicando los campos con ‘-C’ y el parámetro ‘-dump’.

<code>sqlmap -u "http://10.0.2.15:5000/password.php?id=1" -D poc -T flags -C flag_number,flag_value -dump --batch</code>

![image](https://github.com/user-attachments/assets/372113d8-4b27-42fb-8442-f82d53b7b273)

Dentro del campo ‘flag_value’ se encuentra la bandera.

**Flag: 003d873449f8e8ff13b72f2061bfbaa4e5a84b82**
