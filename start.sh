#!/bin/sh

export API_SERVER_ENV=$1

WORK_DIR="`pwd`"
APP_HOME="$(cd `dirname $0`; pwd)"

echo "Start API Server..."
echo "APP_HOME: $APP_HOME"
echo "WORK_DIR: $WORK_DIR"

if [ -f "$APP_HOME/app.pid" ]; then
	echo "API Web server pid is `cat $APP_HOME/app.pid`, kill it."
	kill -9 `cat $APP_HOME/app.pid` > /dev/null 2>&1
fi

if [ -f "$APP_HOME/server.pid" ]; then
	echo "API Server pid is `cat $APP_HOME/server.pid`, kill it."
	kill -9 `cat $APP_HOME/server.pid` > /dev/null 2>&1
fi

if [ -d "$APP_HOME/dist" ]; then
	node $APP_HOME/index.js > /dev/null 2>&1 &
	echo "API Server started."
else
	cd $APP_HOME
	npm run build
	cd $WORK_DIR
	node $APP_HOME/index.js > /dev/null 2>&1 &
	echo "API Server started."
fi

