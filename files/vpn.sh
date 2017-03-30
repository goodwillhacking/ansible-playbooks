#!/usr/bin/expect -f
set config [lindex $argv 0];
set path "/etc/openvpn/client/$config.conf"
if {$config eq ""} {
    puts "Usage: $argv0 vpn_config"
    exit 1
}
if {![file isfile $path]} {
    puts "File $path doesn't exist"
    exit 1
}
puts "Connecting..."
set ldap_user $::tcl_platform(user)
set sudo_pass [exec pass sudo]
set ldap_pass [exec pass puzzle/ldap]
set vpn_pass [exec pass puzzle/vpn/$config]
spawn sudo openvpn $path
expect "password for"
send "$sudo_pass\n"
expect "Enter Auth Username:"
send "$ldap_user\n"
expect "Enter Auth Password:"
send "$ldap_pass\n"
expect "Enter Private Key Password:"
send "$vpn_pass\n"
interact
