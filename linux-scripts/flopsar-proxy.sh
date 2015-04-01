#!/bin/bash
### BEGIN INIT INFO
# Provides: flopsar-dbase
# Default-Start: 3 4 5
# Description: Flopsar Proxy
### END INIT INFO

SCRIPTPATH=.
if test -h $0; then
        SCRIPTPATH=$(dirname "$(ls -l $0 | sed -n 's/.*-> //p')")
else
        SCRIPTPATH=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )
fi

FP_HOME="${SCRIPTPATH}"
FP_USER="flopsar"
FP_COMPONENT="proxy"

# Source functions
. ${FP_HOME}/flopsar-control.sh

case "$1" in
        start)
                s_start
                ;;
        stop)
                s_stop
                ;;
        status)
                s_status
                ;;
        *)
                echo "Usage: {start|stop|status}"
                exit 1
                ;;
esac
exit $?

