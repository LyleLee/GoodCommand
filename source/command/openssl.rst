*****************
openssl
*****************


签发证书流程
================

.. code:: shell

    #CA中心生成自己的证书
    # Generate private key::
    openssl genrsa -out rootCA.key 2048
    # Generate root certificate::
    openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 365 -out rootCA.pem

    #向CA申请签发证书

    NAME=localhost
    # Generate a private key
    openssl genrsa -out $NAME.key 2048
    # Create a certificate-signing request
    openssl req -new -key $NAME.key -out $NAME.csr

    # Create a config file for the extensions
    >$NAME.ext cat <<-EOF
    authorityKeyIdentifier=keyid,issuer
    basicConstraints=CA:FALSE
    keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = $NAME # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
    DNS.2 = bar.$NAME # Optionally, add additional domains (I've added a subdomain here)
    IP.1 = 127.0.0.1 # Optionally, add an IP address (if the connection which you have planned requires it)
    EOF

    # CA中心签发证书
    # Create the signed certificate
    openssl x509 -req -in $NAME.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial \
    -out $NAME.crt -days 30 -sha256 -extfile $NAME.ext

在浏览器中信任根证书rootCA.pem

在服务器中安装 $NAME.crt 和 $NAME.key

https://stackoverflow.com/questions/7580508/getting-chrome-to-accept-self-signed-localhost-certificate?page=1&tab=active#tab-top



查看证书的指纹

.. code:: bash

    openssl x509 -fingerprint -in server.crt