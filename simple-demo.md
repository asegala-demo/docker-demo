# Build the ale-demo-nginx container

````sh
docker build --tag egoalesum/ale-demo-web ale-demo-web
````

# Run the demo container

````sh
docker run --rm --publish 8080:80 egoalesum/ale-demo-web
````
