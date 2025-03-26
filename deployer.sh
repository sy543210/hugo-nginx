#!/bin/sh
flagPath="${FLAG_PATH:-/hugo/deploy.md}"
deployerPath="${DEPLOYER_PATH:-/hugo/blog/}"
nginxPath="${NGINX_PATH:-/html/}"
sleepTime="${SLEEP_TIME:-10}"

log_message() {
  local message="$1"
    local log_level="$2"
      local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        echo "$timestamp - $log_level: $message"
}

# 定义一个函数来处理SIGTERM信号  
handle_sigterm() {  
    [ -n $pid ] && kill $pid
    echo "Received SIGTERM signal. Stopping script."  
    exit 0  
}  

# 捕捉SIGTERM信号并调用handle_sigterm函数来处理  
trap 'handle_sigterm' SIGTERM 
 
while true; do
	inotifywait -qqe 'close_write' $flagPath &
	pid=$!
	wait $pid
 	hugo --quiet --cleanDestinationDir -s $deployerPath && rsync --delete -a "${deployerPath}/public/" $nginxPath
	if [ $? -eq 0 ]; then
		log_message "Successfully deployed $deployerPath to $nginxPath" "INFO"
	else
		log_message "Failed to deploy $deployerPath to $nginxPath" "ERROR"
	fi
	sleep $sleepTime
done
