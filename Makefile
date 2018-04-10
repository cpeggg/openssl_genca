
clean_init:
	-sudo rm -r /etc/ssl/CA
	-sudo rm /etc/ssl/*.pem
	-sudo mkdir /etc/ssl/CA
	-sudo sh -c "echo '01' >/etc/ssl/CA/serial"
	-sudo touch /etc/ssl/CA/index.txt
	-rm ./*.pem
	openssl genrsa -des3 -out /etc/ssl/private/cakey.pem 2048
	openssl req -new -x509 -days 3650 -key /etc/ssl/private/cakey.pem -out /etc/ssl/certs/cacert.pem

build1:
	openssl genrsa -des3 -out /etc/ssl/userkey1.pem 1024
	openssl req -new -days 730 -key /etc/ssl/userkey1.pem -out /etc/ssl/userreq1.pem
	sudo openssl ca -in /etc/ssl/userreq1.pem -out /etc/ssl/newcerts/usercert1.pem -config /etc/ssl/openssl.cnf
build2:
	openssl genrsa -des3 -out /etc/ssl/userkey2.pem 1024
	openssl req -new -days 1095 -key /etc/ssl/userkey2.pem -out /etc/ssl/userreq2.pem
	sudo openssl ca -in /etc/ssl/userreq2.pem -out /etc/ssl/newcerts/usercert2.pem -config /etc/ssl/openssl.cnf
build3:
	openssl genrsa -des3 -out /etc/ssl/userkey3.pem 2048
	openssl req -new -days 1095 -key /etc/ssl/userkey3.pem -out /etc/ssl/userreq3.pem
	sudo openssl ca -in /etc/ssl/userreq3.pem -out /etc/ssl/newcerts/usercert3.pem -config /etc/ssl/openssl.cnf

revoke:
	sudo openssl ca -revoke /etc/ssl/newcerts/01.pem -config /etc/ssl/openssl.cnf
	sudo openssl ca -revoke /etc/ssl/newcerts/02.pem -config /etc/ssl/openssl.cnf

publish:
	sudo openssl ca -gencrl -out ccsec.crl