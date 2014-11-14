#!/bin/bash

HOSTNAME=PAL5CFC09
SCRIPTNAME=${0##*/}
ACTION="$1"

case "$ACTION" in
  start)
	# start server
	synergys --config /etc/synergy.conf
	# start client
	ssh -f -N -R $HOSTNAME:24800:localhost:24800 $HOSTNAME
	ssh $HOSTNAME -t 'DISPLAY=:0 synergyc localhost' 2> /dev/null
	;;
  stop)
	kill -9 `pgrep -f "24800:localhost:24800"` 2> /dev/null
	kill -9 `pidof synergys` 2> /dev/null
	ssh $HOSTNAME -t 'kill -9 `pidof synergyc` 2> /dev/null' 2> /dev/null
	;;
  restart|force-reload)
	synergy.sh stop
	synergy.sh start
	;;
  *)
        echo "Usage: $SCRIPTNAME {start|stop|restart}" >&2
        exit 3
        ;;
esac
