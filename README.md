# born2beroot
Installing a fresh system, and the comands needed for a sucessfull evaluation. 

### passwords
```
root:       w9ayessdMb
user:       Gizch6vBV0
partition:  H9dm21AMo9piJHDBZF01
```

### ssh
check ssh and login from another terminal
```shell
$ sudo service ssh status
.. # or
$ sudo systemctl status ssh
.. # to log in
$ ssh znichola@127.0.0.1 -p 4242
..
$ logout
```
ssh ports are defined in `/etc/ssh/sshd_config`
```shell
sudo nano /etc/ssh/sshd_config
.. # check change with grep
sudo grep  Port /etc/ssh/sshd_config
```

### ufw
check ufw firewall status
```shell
$ sudo ufw status numbered
# will give
active

     To                         Action      From
     --                         ------      ----
[ 1] 4242                       ALLOW IN    Anywhere
[ 2] 22/tcp (v6)                ALLOW IN    Anywhere (v6)
[ 3] 4242 (v6)                  ALLOW IN    Anywhere (v6)
.. # add rule new rule 
$ sudo ufw allow <4242>
.. # delete rule
$ sudo ufw delete <2 to remove the 22 rule>
```

### sudo
```shell
$ su -
$ suermod -aG sudo <username>
$ groups <username>
```
super suser privilages `su -`
```shell 
$ sudo visudo
```
add the line following line to the file
```shell
<username> ALL=(ALL) ALL
```

### new `user` and `group`
creat a new user
```shell
$ sudo adduser <username>             # add new user
..
$ sudo chage -l <username>            # check password status
..
$ sudo adduser <username> <groupname> # add user to group
```

To creat a new user `group` and add `user`to it
```shell
$ sudo addgroup <groupname>           # make a new group
.. 
$ sudo adduser <username> <groupname> #add user to group
.. 
$ getent group <groupname>            #check users in group
```
to check all the current users
```shell
$ cut -d: -f1 /etc/passwd
```
check user password status
```shell
$ chage -l <username>
```
### tty
tty is a service that means a script can't upgrade it's privilages by running sudo.
logged sudo actions are saved in `/var/log/sudo/sudo.log`

### crontab
used to schdule things
```shell

$ sudo crontab -u root -e             # setup a cron job with
.. 
$ sudo crontab -u root -l             # to show the currect crontab tasts to run
# in this format 
# m h  dom mon dow   command 
# do* == day of, month / week
```

### monitoring script
This is a script that is run every 10 mins and displays some informatiom about the system.
```shell
$ sudo nano /usr/local/bin/monitoring.sh
..
$ sudo bash /usr/local/bin/monitoring.sh
```

### ftp as additinal service
a service to transfer files
```shell
sudo service vsftpd status
```