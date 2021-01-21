# same name for image and container
name = cs144

bash:
	sudo docker exec -it ${name} bash

container:
	sudo docker run -di --name ${name} --volume $(shell pwd)/StanfordCS144-sponge:/cs144:z ${name}

image:
	sudo docker build . --tag ${name}

start-container:
	sudo docker start ${name}

clean-container:
	sudo docker container stop ${name}
	sudo docker container rm ${name}


