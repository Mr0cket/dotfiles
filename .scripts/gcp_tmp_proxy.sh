MY_IP=$(curl -s ifconfig.co)
ZONE=$1
STARTUP_SCRIPT="$(cat /Users/milly/scripts/proxy_startup.sh)"

gcloud compute instances create tmp-proxy-02 --machine-type e2-medium --zone $1 \
	--metadata=IP=$MY_IP \
	--metadata-from-file=startup-script=proxy_startup.sh \
	--project=pj-basic-tf-main
