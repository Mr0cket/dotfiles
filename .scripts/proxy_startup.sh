sudo apt update -y
sudo apt -y install squid
IP=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/IP" -H "Metadata-Flavor: Google")
echo "acl localnet src $IP" >> /etc/squid/squid.conf
sudo sed -i 's/#http_access allow localnet/http_access allow localnet/' /etc/squid/squid.conf
sudo systemctl enable squid
sleep 2
sudo systemctl restart squid
sudo systemctl status squid
