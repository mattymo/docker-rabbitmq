#!/bin/bash

puppet apply -v /etc/puppet/modules/nailgun/examples/rabbitmq-only.pp

service rabbitmq-server stop
#Just in case stopping service fails
pkill -u rabbitmq
/usr/sbin/rabbitmq-server
