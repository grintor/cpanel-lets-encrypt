#!/bin/bash
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin
src=/home/georgiatc/letsencrypt/certs/acme-v01.api.letsencrypt.org.directory
usr=username
pwd=password

function install_cert {
   dom=$1
   cert=$(< $src/$dom/cert.pem)
   key=$(< $src/$dom/key.pem)
   curl -s -u $usr:$pwd -F domain=$dom -F cert="$cert" -F key="$key" http://localhost:2082/execute/SSL/install_ssl | python -mjson.tool
}

/home/georgiatc/letsencrypt/acme-client.phar auto
if [ "$?" = "5" ]; then
        install_cert domain1.com
        install_cert domain2.com
fi

