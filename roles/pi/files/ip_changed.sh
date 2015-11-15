ip="$(dig @208.67.222.220 myip.opendns.com +short)" 
ip_changed() {
	echo "$ip" > ~/current_ip
	echo "$(date) $ip" >> ~/ip_changed.log
	echo "$ip" | mutt -s "New IP: $ip" lorenzbischof@gmail.com	
}

if [ ! -e ~/current_ip ]; then
    ip_changed
    exit
fi

old_ip="$(cat ~/current_ip)"
if [ "$ip" != "$old_ip" ]; then
    ip_changed
fi
