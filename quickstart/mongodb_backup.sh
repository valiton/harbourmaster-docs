#!/bin/bash
########
#
# Created by Valiton
#
# Customise variables with values matching your environemnt.
# allway test also the restore of backups
# Backup it not encrypted.
#
########
PATH=/usr/local/bin:/usr/bin:/bin
BACKUP_BASE_DIR="/mnt/mongodb_backup"
TIMESTAMP=$(date +%Y-%m-%d_%H_%M_%S)
BACKUP_DIR="$BACKUP_BASE_DIR/$TIMESTAMP"
BACKUP_FILE_PREFIX="harbourmaster"
DB_HOST="192.168.99.100"
DB_PORT="27017"
S3_BUCKET="MYBUCKETNAME"


HOSTNAME=`hostname`
BACKUP_FILENAME="${BACKUP_FILE_PREFIX}_${HOSTNAME}_mongodb_${TIMESTAMP}.tar.gz"
[ ! -d $BACKUP_BASE_DIR ] || mkdir -p $BACKUP_BASE_DIR
echo "remove backups older than 1 days"
find $BACKUP_BASE_DIR -mindepth 1 -maxdepth 1 -mtime +30 -exec rm -rf {} \;

echo "BACKUP MONGODB $DB_HOST:$DB_PORT TO $BACKUP_FILENAME "
echo "mongodump --host=$DB_HOST:$DB_PORT --out=$BACKUP_BASE_DIR"
mongodump --host=$DB_HOST:$DB_PORT --out=$BACKUP_DIR
echo "COMPRESS BACKUP"
echo "tar czf $BACKUP_BASE_DIR/$BACKUP_FILENAME $BACKUP_DIR"
tar czf $BACKUP_BASE_DIR/$BACKUP_FILENAME $BACKUP_DIR



########
# uplaod the backup to Amazon S3 useing s3cmd http://s3tools.org/s3cmd
# requires configuration of s3cmd befor useing
########
#echo "s3cmd put $BACKUP_BASE_DIR/$BACKUP_FILENAME s3://$S3_BUCKET/$(date +%Y/%m/%d)/"
#s3cmd put $BACKUP_BASE_DIR/$BACKUP_FILENAME s3://$S3_BUCKET/$(date +%Y/%m/%d)/

echo "BACKUP DONE"