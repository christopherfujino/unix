https://bsdimp.blogspot.com/2020/07/simh-setup-for-211bsd-restoration.html

```
PDP-11 simulator V3.8-1
Disabling CR
Disabling RK
Disabling HK
Disabling TM
RQ: creating new file
RQ: creating new file
DLO0, 8b, no dataset, no logging
./2.11bsd-195.ini> set console pchar=01000023600 ; allow vi/more to work
No settable parameters
sim> boot ts
```

```
93Boot from ts(0,0,0172522)
: ts(0,1)
```

```
Boot: bootdev=01000 bootcsr=0172522
Mkfs
file system: ra(0,0)
```

```
file sys size: 15884
```

```
interleaving factor (m; 5 default): 5
```

```
interleaving modulus (n; 100 default): 100
```

```
isize = 10160
m/n = 5 100
Exit called

93Boot from ts(0,0,0172522)
: ts(0,2)
```

```
Boot: bootdev=01000 bootcsr=0172522
Restor
Tape? ts(0,4)
```

```
Disk? ra(0,0)
```

```
Last chance before scribbling on disk.
```

```
End of tape

93Boot from ts(0,0,0172522)
: ra(0,0)unix
```

```
# dd if=/mdec/rauboot of=/dev/ra0a count=1
1+0 records in
1+0 records out
# cd /dev
# rm *mt*
# ./MAKEDEV ts0
# cd /
# newfs ra0g rd54
newfs: /etc/mkfs /dev/rra0g 139298 2 127
isize = 65488
m/n = 2 127
# mount /dev/ra0g /usr
# cd /usr
# mt -f /dev/rmt12 rew
# mt -f /dev/rmt12 fsf 5
# tar xpbf 20 /dev/rmt12
# cd /
# rm -f sys
# ln -s usr/src/sys sys
# cd /usr
# mkdir src
# cd src
# mt -f /dev/rmt12 rew
# mt -f /dev/rmt12 fsf 6
# tar xpbf 20 /dev/rmt12
# mt -f /dev/rmt12 rew
# mt -f /dev/rmt12 fsf 7
# tar xpbf 20 /dev/rmt12
# mv /usr/lib/sendmail /usr/lib/sendmail.off
# chmod 755 / /usr /usr/src /usr/src/sys
# echo /dev/ra0g:/usr:rw:1:2 >> /etc/fstab
# halt
syncing disks... done
halting

HALT instruction, PC: 000014 (MOV #1,13710)
sim> quit
```

## Create a User

https://www.retrocmp.com/how-tos/installing-211bsd-unix-on-pdp-1144/124-installing-211bsd-configuring-terminals-and-users

1) add a line like this into “/etc/master.passwd”:

joerg::101:40::::A regular user:/usr/joerg:/bin/sh
Then execute

# cp master.passwd passwd
# mkpasswd /etc/passwd 
(so passwd.dir and passwd.pag are generated)

Check the entries with

# chpass joerg
! This resets /etc/passwd to old style format!

2) User home directory:

chmod a+r /usr # (only first time, all user must be able to read their “..”)                 
mkdir /usr/joerg
chgrp staff /usr/joerg
chown joerg  /usr/joerg
3) Execute

```sh
# chpass joerg
```

and clear out the “Password:” entry. The user has now empty password, can login and can change its password by executing “$ passwd”

Accounts without password can not be accessed by ftp!

## Set sane TTY behavior

https://retrocomputing.stackexchange.com/questions/13088/using-only-one-terminal-can-i-interrupt-a-process-thats-hung-on-very-early-uni

> In 2.11BSD, I think the kernel defaults are still the same as in v6 (at least, using the old terminal driver), but the command "stty dec" will switch to the more common intr=^C, erase=^? and kill=^U all in a single step. I would have to set up a 2.11BSD system and test this to be sure.

```sh
stty dec
```
