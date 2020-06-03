docker run -it --rm \
	--gpus all \
	--ipc=host \
	-e TZ='Europe/Istanbul' \
	-v cifar10_workspace_data:/workspace \
	--name cifar10_workspace \
	riscue/cifar10_workspace
	#/bin/bash -c 'cd ~/pytorch-cifar10 && python main.py -r -m bit'
