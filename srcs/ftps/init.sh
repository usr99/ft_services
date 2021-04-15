chown ftp-user /home/ftp-user
chmod 744 /home/ftp-user
sed -i "s/<address>/pasv_address=$PASV_IP/" /etc/vsftpd.conf
vsftpd
