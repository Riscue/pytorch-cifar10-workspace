FROM pytorch/pytorch:latest

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
		apt-utils \
		build-essential \
		cmake \
		bzip2 \
		g++ \
		git \
		nano \
		graphviz \
		libgl1-mesa-glx \
		libhdf5-dev \
		openmpi-bin \
		wget \
		curl \
		htop \
		python3 \
		python3-pip \
		python3-venv \
		python3-dev \
		python3-setuptools \
		python3-tk
RUN rm -rf /var/lib/apt/lists/*

RUN pip3 install wheel

WORKDIR /workspace
RUN git clone https://github.com/kuangliu/pytorch-cifar.git

WORKDIR /workspace
RUN git clone https://github.com/eriklindernoren/PyTorch-GAN.git
WORKDIR PyTorch-GAN
RUN pip3 install -r requirements.txt

WORKDIR /workspace
RUN git clone https://github.com/jwyang/faster-rcnn.pytorch.git
WORKDIR faster-rcnn.pytorch
RUN git checkout pytorch-1.0
RUN mkdir data
RUN pip3 install -r requirements.txt
WORKDIR lib
RUN python setup.py build develop

WORKDIR /workspace
RUN git clone https://github.com/matterport/Mask_RCNN.git
WORKDIR Mask_RCNN
RUN pip3 install -r requirements.txt
RUN python3 setup.py install

WORKDIR /workspace
VOLUME ["/workspace"]
ENTRYPOINT ["/bin/bash"]
