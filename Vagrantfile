# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	# Enabling dotenv plugin
	config.env.enable

	# Every Vagrant virtual environment requires a box to build off of.
  	config.vm.box = "ubuntu/trusty64"
 	config.vm.hostname = "vagrant-potenza"

	config.vm.network "private_network", ip: "10.10.10.10"

	# Use guest port on vm, but access server using host port
	config.vm.network "forwarded_port", 
		guest: ENV['GUESTPORT'] ? ENV['GUESTPORT'] : 80,
		host: ENV['HOSTPORT'] ? ENV['HOSTPORT'] : 8080 

	# Synced folder should be application folder
	config.vm.synced_folder ENV['APPFOLDER'] ? ENV['APPFOLDER'] : '', "/var/www/app", :nfs => true

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = 'puppet/manifests'
		puppet.module_path    = 'puppet/modules'
		puppet.manifest_file  = 'init.pp'
	end
end
