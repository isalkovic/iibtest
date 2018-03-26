#!/bin/bash


set -e

NODE_NAME=${NODE_NAME}
EXEC_NAME=${SERVER_NAME}

export HOST_NAME=IIBDOCKER




stop()
{
	echo "----------------------------------------"
	echo "Stopping node $NODE_NAME..."
	mqsistop $NODE_NAME

}

startAndDeploy()
{

	echo "----------------------------------------"
  /opt/ibm/iib-10.0.0.11/iib version
	echo "----------------------------------------"

  NODE_EXISTS=`mqsilist | grep $NODE_NAME > /dev/null ; echo $?`

  if [ ${NODE_EXISTS} -ne 0 ]; then
    echo "----------------------------------------"
    echo "Node $NODE_NAME does not exist..."
    echo "Creating node $NODE_NAME"
		mqsicreatebroker $NODE_NAME
		mqsistart $NODE_NAME
		mqsicreateexecutiongroup $NODE_NAME -e $EXEC_NAME
		mqsistop $NODE_NAME

    echo "----------------------------------------"
	fi
	echo "----------------------------------------"
	echo "Starting syslog"
  sudo /usr/sbin/rsyslogd

	echo "Starting node $NODE_NAME"

  	mqsistart $NODE_NAME
	echo "----------------------------------------"



  	# mqsideploy $NODE_NAME -e $EXEC_NAME -a /etc/mqm/ICPDeploy.bar -m
	# change to deploy all bar files
  	for BAR_FILE in $(ls -v /home/iibuser/*.bar); do
	   echo "About to deploying bar file $BAR_FILE"
	   mqsideploy ${NODE_NAME} -e ${EXEC_NAME} -a ${BAR_FILE}
        done

}

monitor()
{

	# Loop forever by default - container must be stopped manually.
  # Here is where you can add in conditions controlling when your container will exit - e.g. check for existence of specific processes stopping or errors being reported
	while true; do
		sleep 1
	done
}

startAndDeploy
stop
# monitor
