Vagrant.configure(2) do |config|
  config.vm.box = "antonio-malcolm/base-void-x86_64"
  config.vm.hostname = nil

  config.vm.define "localhost" do |localhost|
    localhost.vm.hostname = "localhost"
  end

  config.vm.provision "shell", inline: "xbps-install -Sy python"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end
end
