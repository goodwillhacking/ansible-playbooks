Playbooks that are customized for my own infrastructure. Vagrant is used for testing. Landrush is automatically installed but must be configured:

```sh
sudo apt-get install -y resolvconf dnsmasq
sudo sh -c 'echo "server=/dev/127.0.0.1#10053" > /etc/dnsmasq.d/vagrant-landrush'
sudo service dnsmasq restart
```

