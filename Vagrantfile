#!/usr/bin/env ruby
Vagrant.configure("2") do |config|
    
    # -----------------
    # Define Kali Box:
    # -----------------
    config.vm.define "kali" do |kali|
        kali.vm.box = "e314c/Kali"

        # Set up an internal network card
        kali.vm.network "private_network", ip: "192.168.64.8", virtualbox__intnet: "e314c"
        
        kali.vm.provider "virtualbox" do |v|
            v.name = "E314cBoxes-Kali"
            
            # v.customize [ "modifyvm", :id,  "--nic2", "intnet" ]   # Internal network
            # v.customize [ "modifyvm", :id,  "--intnet2", "e314c" ]   # Join the "e314c" internal network
            v.customize [ "modifyvm", :id,  "--macaddress2", "080027C5BEEF" ]   # Set MAC address: "080027C5BEEF"
            v.customize [ "modifyvm", :id,  "--nicpromisc2", "allow-all" ]      # Promiscous mode ;)
        end
        
        kali.vm.synced_folder "./kaliFiles", "/hostShare"
        kali.vm.synced_folder "./demoScripts", "/demoScripts"
        kali.vm.synced_folder '.', '/vagrant', disabled: true # disable the default share (Because it's useless to us)
    end
    
    
    # -------------------------------
    # Define Ubuntu instance
    # -------------------------------
    config.vm.define "ubuntu" do |ubuntu|
        ubuntu.vm.box = "ubuntu/xenial64"
        
        # Set up an internal network card
        ubuntu.vm.network "private_network", ip: "192.168.64.4", virtualbox__intnet: "e314c"
        
        ubuntu.vm.provider "virtualbox" do |v|
            v.name = "E314cBoxes-ubuntu"
            v.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]  #Remove debug UART log from ubuntu/xenial64 https://groups.google.com/forum/#!topic/vagrant-up/eZljy-bddoI
            
            # v.customize [ "modifyvm", :id,  "--nic2", "intnet" ]              # Internal network
            # v.customize [ "modifyvm", :id,  "--intnet2", "e314c" ]            # Join the "e314c" internal network
            v.customize [ "modifyvm", :id,  "--macaddress2", "080027C5ABBA" ]   # Set MAC address: "080027C5ABBA"
            v.customize [ "modifyvm", :id,  "--nicpromisc2", "allow-all" ]      # Promiscous mode ;)
        end
        
        ubuntu.vm.synced_folder "./ubuntuFiles", "/hostShare"
        ubuntu.vm.synced_folder '.', '/vagrant', disabled: true # disable the default share (Because it's useless to us)
        
        # --- Using ansible --- #
        # Move across any files needed on the machine
        ubuntu.vm.provision "file", source: "./ansible", destination: "/tmp/ansible"
        ubuntu.vm.provision "shell", inline: "sudo rm -f -r /ansible"
        ubuntu.vm.provision "shell", inline: "sudo mv /tmp/ansible /"   # Three step just to make sure there's no old ansible stuff in there.
        
        # Provisioning with ansible (using the guestVM to sort itself out)
        ubuntu.vm.provision :ansible_local do |ansible|
            ansible.provisioning_path = "/ansible"
            ansible.playbook = "ubuntuPlaybook.yml"
            ansible.become = true
        end
        
    end
    
    
    # -------------------------------
    # Define Metasploitable instance
    # -------------------------------
    # Originally I wanted this to be Internal network only. However, the Rapid7 page seems 
    # to detail that NAT is fine for this machine.
    # Still, I recommend manually switching off the NAT network inside the machine 
    # -------------------------------
    config.vm.define "metasploitable" do |metasploitable|
        metasploitable.vm.box = "e314c/Metasploitable2"
        
        # Set up an internal network card
        metasploitable.vm.network "private_network", ip: "192.168.64.2", virtualbox__intnet: "e314c"
        
        metasploitable.vm.provider "virtualbox" do |v|
            v.name = "E314cBoxes-metasploitable2"
            # v.customize [ "modifyvm", :id,  "--nic2", "intnet" ]   # Internal only
            # v.customize [ "modifyvm", :id,  "--intnet2", "e314c" ]   # Join the "e314c" internal network
            v.customize [ "modifyvm", :id,  "--macaddress2", "080027C5DEAD" ]   # Set MAC address: "080027C5DEAD"
            v.customize [ "modifyvm", :id,  "--nicpromisc2", "allow-all" ]      # Promiscous mode ;)
        end
        metasploitable.vm.synced_folder '.', '/vagrant', disabled: true # disable the default share (vboxfs isn't installed on the machine)
    end

end
