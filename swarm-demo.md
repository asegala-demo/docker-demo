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
# Build ale-demo-aspnet and publish to Docker Hub
docker build -t egoalesum/ale-demo-aspnet ale-demo-aspnet
docker push egoalesum/ale-demo-aspnet

# Build ale-demo-proxy and publish to Docker Hub
docker build -t egoalesum/ale-demo-proxy ale-demo-proxy
docker push egoalesum/ale-demo-proxy
````

# Launch services

````sh
# Pull images for quicker startup
docker pull egoalesum/ale-demo-aspnet
docker pull egoalesum/ale-demo-proxy

# Launch services
docker service create \
  --name webapp \
  --network demo-net \
  --publish 5000:5000 \
  egoalesum/ale-demo-aspnet

docker service create \
  --name proxy \
  --network demo-net \
  --publish 80:80 \
  egoalesum/ale-demo-proxy
````

# Have fun

````sh
# Check status
docker service ls

# Scale services
docker service scale webapp=2 proxy=2
````

# Cleanup

````sh
docker service rm webapp
docker service rm proxy
docker network rm demo-net
docker swarm leave --force
````
