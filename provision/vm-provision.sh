echo "Installing prerequisites"

apt-get update
apt-get install -y nginx

echo "Setting up SSL certificate"
cd /provision/ssl
cp cert/jitsissl.crt /etc/ssl/certs/jitsissl.crt
cp private/jitsissl.key /etc/ssl/private/jitsissl.key

echo "Add configuration"
cd /provision/nginx
cp jitsi-meet /etc/nginx/sites-available/jitsi-meet
cd /etc/nginx/
rm -Rf sites-enabled
mkdir sites-enabled
ln -s /etc/nginx/sites-available/jitsi-meet /etc/nginx/sites-enabled/jitsi-meet

echo "Create symlink to the project"
cd /usr/share/nginx
ln -s /jitsi-meet jitsi-meet

echo "Restart NGINX"
service nginx restart
