Vagrant.configure(2) do |config|
  config.vm.box = "terrywang/archlinux"

  config.vm.define "localhost" do |localhost|
    localhost.vm.hostname = "localhost"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "desktop.yml"
  end
end
