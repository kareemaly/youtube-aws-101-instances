#!/bin/bash

yum install -y nc

while true
do
  echo ""
  nc -l -p 80 -c 'echo -e "HTTP/1.1 200 OK\n\n${server_info}\n$(curl ${next_server_ip})"'
done

