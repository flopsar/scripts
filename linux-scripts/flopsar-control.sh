#!/bin/bash

FP_COMPONENT_HOME="${FP_HOME}/flopsar-${FP_COMPONENT}"
FP_PID="${FP_COMPONENT_HOME}/var/flopsar.pid"

s_status() {
        if [ -e ${FP_PID} ]
        then
                DAEMON_PID=`cat ${FP_PID}`
                ps -p "${DAEMON_PID}" > /dev/null 2>&1
                if [ $? -eq 0 ]
                then
                        echo "Running. PID: ${DAEMON_PID}"
                else
                        echo "Stopped."
                        echo "Warning. Pidfile exists"
                fi
        else
                echo "Stopped."
        fi
}


s_start() {
        echo "Starting ${FP_COMPONENT}:"
        if [ -e ${FP_PID} ]
        then
                echo "Failure. Pidfile already exists"
                return 1
        fi

	echo "${FP_HOME}/fprocessor -m ${FP_COMPONENT} -d ${FP_HOME}"
	if [ `id -un` = "${FP_USER}" ]
	then
		${FP_HOME}/fprocessor -m ${FP_COMPONENT} -d ${FP_HOME}
	else
		su - ${FP_USER} -c "${FP_HOME}/fprocessor -m ${FP_COMPONENT} -d ${FP_HOME}"
	fi
	sleep 1
        DAEMON_PID=`cat ${FP_PID}`
        ps -p "${DAEMON_PID}" > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
                echo "Started. PID: ${DAEMON_PID}"
        else
                echo "Start failed. Check ${FP_COMPONENT_HOME}/logs"
        fi
}


s_stop() {
        if [ -e ${FP_PID} ]
        then
                DAEMON_PID=`cat ${FP_PID}`
                echo "Stoping ${FP_COMPONENT}: ${DAEMON_PID}"
                kill -s INT ${DAEMON_PID}
                echo "Stop signal sent successfully."
                echo -n "Waiting for exit: "
                MAX_WAIT=120
                ps -p "${DAEMON_PID}" > /dev/null 2>&1
                PROC_STATUS=$?
                while [ ${PROC_STATUS} -eq 0 ]
                do
                        sleep 1
                        echo -n "."
                        ps -p "${DAEMON_PID}" > /dev/null 2>&1
                        PROC_STATUS=$?

                        MAX_WAIT=$(( $MAX_WAIT - 1 ))
                        if [ ${MAX_WAIT} -eq 0 ]
                        then
                                echo "Terminated"
                                kill -9 ${DAEMON_PID}
                                PROC_STATUS=1
                        fi
                done
                echo ""
                echo "Exited"
        else
                echo "Stop failed. File not exitsts: ${FP_PID}"
        fi
}
