docker run -d --rm \
	--gpus all \
	--ipc=host \
	-e TZ='Europe/Istanbul' \
	-e DISPLAY=${DISPLAY} \
	-v cifar10_workspace_data:/workspace \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-p 80:8000 \
	--name cifar10_workspace \
	riscue/cifar10_workspace
	#/bin/bash -c 'cd ~/pytorch-cifar10 && python main.py -r -m bit'
