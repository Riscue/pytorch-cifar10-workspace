docker run -it --rm \
	--ipc=host \
	-e TZ='Europe/Istanbul' \
	-v pytorch_workspace_data:/workspace \
	--name pytorch_workspace \
	riscue/pytorch_workspace
