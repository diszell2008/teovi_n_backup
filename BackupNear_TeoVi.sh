#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=.near
BACKUPDIR=$HOME/backups/

mkdir $BACKUPDIR

sudo systemctl stop neard.service

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts
    echo "Compressing backup...."
    tar -zcvf /root/backups/near_${DATE}.tar.gz -C $HOME/.near/data .

    # cp -rf $DATADIR/data/ ${BACKUPDIR}/

    # Submit backup completion status, you can use healthchecks.io, betteruptime.com or other services
    # Example
    curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/622bc08f-38fa-4ad0-8308-6d9b534d33b2

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node was started" | ts
