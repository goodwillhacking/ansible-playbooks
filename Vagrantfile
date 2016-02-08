Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "localhost" do |localhost|
    localhost.vm.hostname = "localhost"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "desktop.yml"
  end
end
