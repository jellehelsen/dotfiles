#!/usr/bin/env bash

export BORG_REPO='miner:~/laptop_backup'
export BORG_PASSPHRASE='slow detect nation super among'

borg create --exclude-caches ::{hostname}-{user}-{utcnow} ${HOME}
backup_exit=$?

borg prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6
