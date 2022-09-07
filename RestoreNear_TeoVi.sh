#!/bin/bash
echo "Stoping Neard Service"
systemctl stop neard

#Remove Current DATA
rm -rf .near/data
echo "Remove Current Data"

#Select Newest Date Backup
lastdateCompressBackup=`ls /root/backups/ | awk -F_ '{print $1 " " $2}' | sort -n -k 2 | tail -1 | sed 's/ /_/'`

#Uncompressed Backup
echo "Uncompressing Backup...."
mkdir $HOME/.near/data

tar -xvf /root/backups/$lastdateCompressBackup -C $HOME/.near/data

#Remove OLD backup
olddateCompressBackup=`ls /root/backups/ | awk -F_ '{print $1 " " $2}' | sort -nr -k 2 | tail -1 | sed 's/ /_/'`

rm $HOME/backups/$olddateCompressBackup

#Restart Service
systemctl start neard
journalctl -u neard -f -o cat | ccze -A