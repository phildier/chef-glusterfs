# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "precise64"

	config.vm.define "gluster1" do |gluster1|
		gluster1.vm.box = "precise64"
		gluster1.vm.network :private_network, ip: "192.168.33.10"
		gluster1.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "."
			chef.roles_path = "roles"
			chef.add_role "server"
		end
	end

	config.vm.define "gluster2" do |gluster2|
		gluster2.vm.box = "precise64"
		gluster2.vm.network :private_network, ip: "192.168.33.11"
		gluster2.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "."
			chef.roles_path = "roles"
			chef.add_role "server"
		end
	end

	config.vm.define "client" do |client|
		client.vm.box = "precise64"
		client.vm.network :private_network, ip: "192.168.33.12"
		client.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "."
			chef.roles_path = "roles"
			chef.add_role "opsworks_client"
		end
	end

end

# vim:set ts=4 sw=4:
