#!/bin/bash

#useles scroipt

#color variables
end="\033[0m"
red="\033[0;31m"
blue="\033[0;34m"
green='\e[32m'
purple="\033[0;35m"



function ColorBlue() {
  echo -e "${blue}$1${end}"
}

function ColorRed() {
	echo -e "${red}$1${end}"
}

function ColorPurple() {
	echo -e "${purple}$1${end}"
}

function ColorGreen() {
	echo -e "${green}$1${end}"
}


echo -ne $(ColorBlue 'text in blue')


#menu function

function menu() {
	echo -ne "
	Choose an option:
	$(ColorPurple '1)') $(ColorBlue 'Memory')
	$(ColorPurple '2)') $(ColorBlue 'CPU load')
	$(ColorPurple '3)') $(ColorBlue 'TCP')
	$(ColorPurple '4)') $(ColorBlue 'Kernel')
	$(ColorPurple '5)') $(ColorBlue 'Check all')
	$(ColorPurple '0)') Quit
	$(ColorRed 'Choose an option:')"
	read answer
	case $answer in 
					1) memory_check ; menu ;;
					2) cpu_check ; menu ;;
					3) tcp_check ; menu ;;
					4) kernel_check ; menu ;;
					5) checks ; menu ;;
					0) exit 0 ; menu ;;
					*) echo -e $red"Option not available"$end; WrongCommand;;
	
	esac
}

server_name=$(hostname)

function memory_check() {
	echo -e "\e[32m"
	echo  "Checking memory of $server_name:"
	free -m | awk 'NR==2{print "Used:"$3"/""Free:"$2}'
	echo -e ""
	echo -e "\033[0m"
}

function cpu_check() { #output cpu pas clair a comprendre et a interprerter
	echo -e "\e[32m"
	echo  "Checking cpu usage of $server_name:"
	uptime | awk '{print $1"\n"$6 $7 " "$8 $9 $10}' 
	echo "Utilisation global:"
	grep 'cpu' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}' #mieux
	echo -e "\033[0m"
	echo -e "\n"
}

function tcp_check() {
	echo -e "\e[32m"
	echo "Checking all tcp connections on $server_name:"
	ss -s | grep TCP
	echo -e "\033[0m"
	echo -e "\n"
}

function kernel_check() {
	echo -e "\e[32m"
	echo  "Checking kernel version on $server_name:"
	uname -r
	echo "Shell:" $SHELL 
	echo -e "\033[0m"
	echo -e "\n"
}

function checks() {
	#echo -e "green='\e[32m'"
	memory_check
	cpu_check
	tcp_check
	kernel_check
	#echo -e "green='\e[32m'"
	exit 0
}

menu
