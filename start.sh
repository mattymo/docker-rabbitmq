#!/bin/bash

puppet apply -d -v /root/site.pp

service rabbitmq-server stop

/usr/sbin/rabbitmq-server
