VM export TODO list:
	
1. Run setup script (<https://raw.githubusercontent.com/nesfit/PDS-VM/master/install.sh>) and halt
2. Zerofree root partition (<https://unix.stackexchange.com/a/310467>)
	1. Boot to recovery mode (Shift while booting / Advanced / recovery mode / root)
	2. Edit `/etc/fstab` to add `ro` parameter to the root partition at `/` `dev/sda1`
	3. Reboot to recovery mode
	4. `zerofree -v /dev/sda1`
	5. Edit `/etc/fstab` to remove `ro` parameter of the root partition
	6. `halt`
3. Take snapshot
4. Export appliance  
