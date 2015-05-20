# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.box       = "treehouse-rails4"
  config.vm.box_url   = "http://vm.teamtreehouse.com/treehouse-rails4.box"
  config.ssh.username = "treehouse"
  
  config.vm.network :forwarded_port, guest: 3024, host: 3024
  config.vm.synced_folder "./projects", "/home/treehouse/projects"
end
