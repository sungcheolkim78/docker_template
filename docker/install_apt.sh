RED='\033[0;31m'
NC='\033[0m' # No Color
echo "${RED}-------------------------------------------------------------------------------------"
echo "------------------------------ Installing APT packages ------------------------------"
echo "-------------------------------------------------------------------------------------${NC}"
sleep 3
PYTHON_VERSION="3.8"
DEBIAN_FRONTEND=noninteractive

# prepare nodejs for jupyter notebook
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    docker.io \
    git \
    gnupg2 \
    iputils-ping \
    libhdf5-serial-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    lsb-release \
    net-tools \
    neovim \
    nodejs \
    nvtop \
    openssh-server \
    python3 \
    python3-dev \
    python3-distutils \
    python3-pip \
    python3-tk \
    pwgen \
    file \
    tmux \
    tmuxp \
    unzip \
    wget \
    zsh

# do not upgrade to fix CUDA toolkits
# apt-get upgrade -y

# install configurable-http-proxy
npm install -g configurable-http-proxy

