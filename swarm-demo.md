# Prepare the environment

````sh
# Azure template:
# https://github.com/Azure/azure-quickstart-templates/tree/master/coreos-with-fleet-multivm

# Ensure that we're on the "alpha" channel for CoreOS
# SSH into each VM
echo 'GROUP=alpha' | sudo tee /etc/coreos/update.conf
sudo systemctl restart update-engine
sudo update_engine_client -update
sudo locksmithctl reboot

# Start the Docker Swarm cluster
# SSH into the first VM
docker swarm init --advertise-addr eth0

# Copy the command (similar to `sudo docker swarm join --token SWMTKN-<token> 10.0.0.4:2377`) and execute it in all ohter VMs

# Create an overlay network
# Execute in the manager node
docker network create \
  --driver overlay \
  --subnet 192.168.1.0/24 \
  demo-net
````

# Build Docker images

````sh
docker build -t egoalesum/ale-demo-aspnet ale-demo-aspnet
docker build -t egoalesum/ale-demo-proxy ale-demo-proxy
````
