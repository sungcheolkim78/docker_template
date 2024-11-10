RED='\033[0;31m'
NC='\033[0m' # No Color
echo "${RED}-------------------------------------------------------------------------------------"
echo "------------------------------ Installing PIP packages ------------------------------"
echo "-------------------------------------------------------------------------------------${NC}"
sleep 3

# install pytorch with cu113 (next version is cu116)

# We split installations between different steps to limit issues.
pip3 install --upgrade pip
pip3 install wheel
pip3 install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu116
pip3 install \
    boto3 \
    dvc \
    einops \
    ipython \
    jupyterhub \
    jupyterlab \
    matplotlib>=3.2.2 \
    numpy>=1.21 \
    PyYAML>=5.3.1 \
    pyyaml \
    pillow-simd \
    Pillow>=8.3.2 \
    pretty_confusion_matrix \
    scikit-learn \
    scikit-image \
    scipy>=1.4.1 \
    gitpython
pip3 install pydantic
pip3 install sklearn
pip3 install tensorboard
pip3 install tables
pip3 install seaborn
pip3 install git+https://github.com/h2oai/datatable
pip3 install pandas
pip3 install pretty_confusion_matrix

ldconfig
