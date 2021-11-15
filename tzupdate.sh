#! /bin/sh

tz=''

get_tz() {
	tz=`curl -s http://ip-api.com/line?fields=timezone`
	if [ "$tz" = "" ]; then
		echo "ERROR> get Fail"
		exit 1
	else
		echo "INFO> get $tz"
	fi
}

chk_tz() {
	chk=`timedatectl list-timezones | grep $tz | wc -l`
	if [ "$chk" = "1" ]; then
		echo "INFO> check Pass"
	else
		echo "ERROR> check Fail"
		exit 1
	fi
}

set_tz() {
	timedatectl set-timezone $tz
	if [ "$?" = "0" ]; then
		echo "INFO> set OK"
	else
		echo "ERROR> set Fail!"
		exit 1
	fi
}

do_main() {
	get_tz
	chk_tz
	set_tz
}

do_main
