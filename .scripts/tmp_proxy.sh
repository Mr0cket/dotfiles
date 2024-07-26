#!/bin/bash

# Set your GCP project and zone
PROJECT_ID="pj-basic-tf-main"
ZONE="asia-east1-a"

# Set the VM name
VM_NAME="socks-proxy-vm"

# Set the machine type
MACHINE_TYPE="n1-standard-1"

# Set the image family and project

# Create a new VM
#gcloud compute instances create $VM_NAME \
#    --project=$PROJECT_ID \
 #   --zone=$ZONE \
 #   --machine-type=$MACHINE_TYPE

# Get the external IP address of the VM
EXTERNAL_IP=$(gcloud compute instances describe $VM_NAME --project=$PROJECT_ID --zone=$ZONE --format="value(networkInterfaces[0].accessConfigs[0].natIP)")

# SSH into the VM and configure it as a SOCKS proxy
gcloud compute ssh $VM_NAME -L 1080:localhost:1080 << EOF
    # Install necessary packages
    sudo apt-get update
    sudo apt-get install -y dante-server

    # Configure Dante SOCKS proxy
    sudo tee /etc/danted.conf > /dev/null << EOL
    logoutput: /var/log/socks.log
    internal: eth0 port = 1080
    external: eth0
    clientmethod: none
    user.privileged: proxy
    user.unprivileged: nobody
    user.libwrap: nobody
    client pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: error
    }
    EOL

    # Restart Dante service
    sudo systemctl restart danted
EOF

echo "SOCKS proxy VM deployed and configured. Connect to it using localhost:1080 as the SOCKS proxy."

