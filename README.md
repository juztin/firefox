# firefox-dev
Dockerized Firefox Developer Edition

### Build
Clone the repo, or simply download the `Dockerfile`  

##### Firefox Release (38.0)

```shell
% docker build -t minty/firefox .
```

##### Firefox Developer (latest)

```shell
% docker build -f Dockerfile-dev -t minty/firefox:dev .
```

##### Firefox Nightly (41.0a1)

```shell
% docker build -f Dockerfile-nightly -t minty/firefox:nightly .
```

### Run

Place something like the below into a script somewhere, `~/bin/firefox`:

```shell
#!/bin/bash

name="firefox"
image="minty/firefox"
profile=".mozilla"
version=$1
if [ -z "$version" ]; then
	name="firefox-release"
else
	name="$name-$version"
	image="$image:$version"
	profile="$profile-$version"
fi

exists=$(docker ps -a --filter name=$name | grep -P "\s$name( |$)")
if [ -z "$exists" ]; then
	docker run -it \
		--net host \
		--cpuset-cpus 0 \
		--memory 512mb \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY \
		-v $HOME/Downloads:/root/Downloads \
		-v $HOME/$profile:/data \
		-v /dev/snd:/dev/snd --privileged \
		--name $name\
		$image
else
	docker start -a $name
fi
```

Then execute it with the environment you'd like:

```shell
% firefox
% firefox dev
% firefox nightly
```


