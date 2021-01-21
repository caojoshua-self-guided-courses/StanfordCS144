# same name for image and container
name = cs144

bash:
	docker exec -it ${name} bash

container:
	docker run -di --name ${name} --volume $(shell pwd)/StanfordCS144-sponge:/cs144:z ${name}

image:
	docker build . --tag ${name}

clean-container:
	docker container stop ${name}
	docker container rm ${name}


