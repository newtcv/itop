#!/bin/sh

# execute any pre-init scripts, useful for images
# based on this image
for i in /scripts/pre-init.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-init.d - processing $i"
		. "${i}"
	fi
done

# set apache as owner/group

chown -R apache:apache /app
mkdir -p /var/log/apache2
chown -R apache:apache /var/log/apache2 
mkdir -p /run/apache2
chown -R apache:apache /run/apache2



# display logs
tail -F /var/log/apache2/*log &

# execute any pre-exec scripts, useful for images
# based on this image
for i in /scripts/pre-exec.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-exec.d - processing $i"
		. "${i}"
	fi
done

echo "[i] Starting daemon..."
# run apache httpd daemon
httpd -D FOREGROUND
