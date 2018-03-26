#!/bin/bash

set -e

NODE_NAME=${NODE_NAME}
EXEC_NAME=${SERVER_NAME}

export HOST_NAME=IIBDOCKER


startIntegrationNode()
{

	echo "----------------------------------------"

	echo "Starting node $NODE_NAME"

  	mqsistart $NODE_NAME
	echo "----------------------------------------"


}

monitor()
{

	# Loop forever by default - container must be stopped manually.
  # Here is where you can add in conditions controlling when your container will exit - e.g. check for existence of specific processes stopping or errors being reported
	while true; do
		sleep 1
	done
}

startIntegrationNode
# ovaj monitor je iz nekog razloga kljucna stvar, ako nema te komande, container se ugasi odmah nakon starta
monitor
