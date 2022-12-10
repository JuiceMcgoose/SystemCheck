#!/bin/bash

server_name=$(hostname)

function memory_check() {
	echo  "Checking memory of $server_name:"
	free -h
	echo -e "\n"
}

function cpu_check() {
	echo  "Checking cpu usage of $server_name:"
	uptime
	echo -e "\n"
}

function tcp_check() {
	echo "Checking all tcp connections on $server_name:"
	ss -s | grep TCP
	echo -e "\n"
}

function kernel_check() {
	echo  "Checking kernel version on $server_name:"
	uname -r
	echo -e "\n"
}

function checks() {
	memory_check
	cpu_check
	tcp_check
	kernel_check
	exit 0
}


checks
