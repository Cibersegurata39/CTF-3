# CTF-3
*Capture the flag* donde se trabaja la enumeración y *fingerprinting*, .
<div>
  <img src="https://img.shields.io/badge/-Kali-5e8ca8?style=for-the-badge&logo=kalilinux&logoColor=white" />
  <img src="https://img.shields.io/badge/-Nmap-6933FF?style=for-the-badge&logo=nmap&logoColor=white" />
  <img src="https://img.shields.io/badge/-Dirsearch-005571?style=for-the-badge&logo=dirsearch&logoColor=white" />
  <img src="https://img.shields.io/badge/-Metasploit-2596CD?style=for-the-badge&logo=metasploit&logoColor=white" />
  <img src="https://img.shields.io/badge/-python-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/-steghide-FF5200?style=for-the-badge&logo=steghide&logoColor=white" />
  <img src="https://img.shields.io/badge/-Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
</div>
## Objetivo

Explicar la realización del siguiente _Capture the flag_ dentro del mundo educativo. Se preteneden conseguir dos archivos (_flags_), el cual se encuentra dentro del entorno del usuario básico. Para ello, se deberá penetrar en la máquina, y pasar al usuario básico. En otro repositorio se explicará como a aprtir d esta maquina se podra pivotar hacia otra máquina.

## Que hemos aprendido?

- Realizar fingerprinting y enumeración de puertos y enumeración web (mediante *Dirbuster*).

## Herramientas utilizadas

- *Kali Linux*.
- Enumeración: *Nmap*, *Dirbuster*.
- Penetración: **. 

## Steps

### Enumeración y fingerprinting

La máquina a vulnerar está desplegada dentro de un *Docker*, en este caso se encuentra corriendo en uno de nuestros puertos. Así pues, **nmap** es lanzado con la IP destino de la máquina anfitriona para buscar en que puerto está corriendo la máquina víctima. Como resultado se descubre el puerto 5000 donde corre un servicio *upnp*, donse se encuentra la máquina.

<code>nmap -p- -Pn -sV 10.0.2.15</code>

![image](https://github.com/user-attachments/assets/614d71a1-2cb7-416e-b7f6-879e8eef422a)

Al acceder a la URL 10.0.2.15:5000 desde el navegador, doy con un mensaje, el cual da a entender que encontraré varias vulnerabilidades por el camino.

![image](https://github.com/user-attachments/assets/777a9c55-1abf-4700-aa77-f8afebc84477)


### Vulnerabilidades explotadas


**Flag: **

**Flag: **
