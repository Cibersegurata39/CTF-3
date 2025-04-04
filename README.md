# CTF-3
*Capture the flag* donde se trabaja la enumeración y *fingerprinting*, *Metasploit*, *Python 3*, *Steghide* y la escalada de privilegios.
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

Explicar la realización del siguiente _Capture the flag_ dentro del mundo educativo. Se preteneden conseguir dos archivos (_flags_), uno dentro del entorno del usuario básico y el otro en el entorno _root_. Para ello, se deberá penetrar en la máquina, pasar al usuario básico y realizar una escalada de privilegios.

## Que hemos aprendido?

- Realizar fingerprinting y enumeración de puertos y enumeración web (mediante *Dirsearch*).
- Explotar vulnerabilidades con *Metasploit*.
- Montar un sevidor fácilmente con *Python*.
- Decodificar código en base64 o hexadecimal.
- Buscar información oculta en imágenes con *Steghide*.
- Escalada de privilegios.

## Herramientas utilizadas

- *Kali Linux*.
- Enumeración: *Nmap*, *Dirsearch*.
- Penetración: *Metasploit*, *Python3*, *Steghide*. 

## Steps

### Enumeración y fingerprinting

La máquina a vulnerar está desplegada dentro de un *Docker*, para encontrar este desde el terminal de Kali, se busca su direción IP con el comando <code>ipconfig</code>. En la respuesta se averigua que su dirección IP es la 172.17.0.1, por lo que la máquina víctima debe estar en la red 172.17.0.X. Utilizando la herramienta __nmap__ puedo hacer un barrido para encontrar el *host* que estoy buscando, para hacerlo más rápido no compruebo puertos. Una vez la máquina ha sido localizada, con la ayuda de __nmap__ se buscan los puertos de la máquina que se encuentran abiertos y las versiones que corren en ellos. (Para cualquier duda, consultar el repositorio CTF-1). 


### Vulnerabilidades explotadas


**Flag: **

**Flag: **
