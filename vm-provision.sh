echo "Installing prerequisites"

sudo apt-get update
sudo apt-get install -y git npm nodejs-legacy
sudo npm -g static-server

echo "Go to working directory"
cd /jitsi-meet

echo "Link lib-jitsi-meet dependency to local copy"
cd /lib-jitsi-meet
npm link
cd /jitsi-meet
npm link lib-jitsi-meet

echo "Installing dependencies"
npm install --force
