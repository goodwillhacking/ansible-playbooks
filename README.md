Playbooks that are customized for my own infrastructure. 

# Playbooks

## digitalocean
This is for my production stuff that runs on a Digitalocean Droplet. Vagrant is used for testing. Landrush is automatically installed but must be configured:

```sh
sudo apt-get install -y resolvconf dnsmasq
sudo sh -c 'echo "server=/dev/127.0.0.1#10053" > /etc/dnsmasq.d/vagrant-landrush'
sudo service dnsmasq restart
```
## desktop
Configures a desktop environment. Uses localhost.

## pi
Configures my raspberry pi. 
image: https://github.com/debian-pi/raspbian-ua-netinst
firstboot: ansible-playbook setup_pi.yml
