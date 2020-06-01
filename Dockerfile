FROM pytorch/pytorch:latest

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
        apt-utils \
        build-essential \
        git \
        nano \
        curl

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN git clone https://github.com/Riscue/pytorch-cifar10.git
WORKDIR pytorch-cifar10
RUN python state_dicts.py -d -e -r
RUN python -c "import torchvision;torchvision.datasets.CIFAR10(root='./data',download=True)"

WORKDIR /workspace
RUN git clone https://github.com/kuangliu/pytorch-cifar.git

WORKDIR /workspace
RUN git clone https://github.com/huyvnphan/PyTorch_CIFAR10.git

WORKDIR /workspace
VOLUME ["/workspace"]
ENTRYPOINT ["/bin/bash"]
