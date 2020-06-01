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

ARG WORKSPACE=/workspace
ARG user=user
ARG group=user
ARG uid=1000
ARG gid=1000

RUN mkdir -p $WORKSPACE \
  && chown ${uid}:${gid} $WORKSPACE \
  && groupadd -g ${gid} ${group} \
  && useradd -d "$WORKSPACE" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

USER ${user}

WORKDIR $WORKSPACE
RUN git clone https://github.com/Riscue/pytorch-cifar10.git
WORKDIR pytorch-cifar10
RUN python state_dicts.py -d -e -r
RUN python -c "import torchvision;torchvision.datasets.CIFAR10(root='./data',download=True)"

WORKDIR $WORKSPACE
RUN git clone https://github.com/kuangliu/pytorch-cifar.git

WORKDIR $WORKSPACE
RUN git clone https://github.com/huyvnphan/PyTorch_CIFAR10.git

WORKDIR $WORKSPACE
VOLUME $WORKSPACE
ENTRYPOINT ["/bin/bash"]
