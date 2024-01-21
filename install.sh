# INSTRUCTIONS
# Download software.zip from sharepoint to /tmp/software.zip and unzip it or copy it
# scp ~/Downloads/Software.zip kristo@toy2dac:/tmp/software.zip
# unzip /tmp/software.zip
# Remove metis, parmetis and mumps packages from math_2024 folder 
# rm /tmp/Software/math_2024/metis-5.1.0/ /tmp/Software/math_2024/MUMPS_5.1.2/ /tmp/Software/math_2024/parmetis-4.0.3/ -rdf
# copy install.sh to /tmp/install.sh and chmod +x /tmp/install.sh   
# 
# run calculations by
# cd /tmp/Software/TOY2DAC/run_fwi_2/
# mpirun -n 1 ../bin/toy2dac
# Basic devel packages
sudo apt-get install build-essential -y
sudo apt-get install unzip -y

# install cmake
cd /opt
sudo wget https://github.com/Kitware/CMake/releases/download/v3.28.1/cmake-3.28.1-linux-x86_64.sh
sudo chmod +x cmake-3.28.1-linux-x86_64.sh
sudo ./cmake-3.28.1-linux-x86_64.sh
sudo mv cmake-3.28.1-linux-x86_64 cmake
sudo ln -s /opt/cmake/bin/* /usr/local/bin
# NEED TO ENTER y twice to install cmake

# Add package repository
sudo apt-get install -y gpg-agent wget
wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | sudo apt-key add -
sudo apt-add-repository 'deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main'

# Install run-time packages
sudo apt-get update
sudo apt-get install intel-opencl-icd intel-level-zero-gpu level-zero intel-media-va-driver-non-free libmfx1 -y

# Install developer packages
sudo apt-get install libigc-dev intel-igc-cm libigdfcl-dev libigfxcmrt-dev level-zero-dev

cd /tmp
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB

echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
sudo apt update

sudo apt install intel-basekit -y
sudo apt install intel-hpckit -y

echo "source /opt/intel/oneapi/setvars.sh" >> ~/.bashrc

# install metis and gklib
cd /tmp/Software/math_2024
git clone https://github.com/KarypisLab/GKlib.git
git clone https://github.com/KarypisLab/METIS.git
mv METIS metis

make config prefix=/tmp/Software/math_2024/metis/libmetis -C /tmp/Software/math_2024/GKlib
make -C /tmp/Software/math_2024/GKlib
make install -C /tmp/Software/math_2024/GKlib

make config -C /tmp/Software/math_2024/metis gklib_path=/tmp/Software/math_2024/metis/libmetis/
make -C /tmp/Software/math_2024/metis
make install -C /tmp/Software/math_2024/metis

# install parmetis
git clone https://github.com/KarypisLab/ParMETIS.git
mv ParMETIS parmetis
make config cc=mpicc prefix=~/local -C /tmp/Software/math_2024/parmetis gklib_path=/tmp/Software/math_2024/metis/libmetis/
make -C /tmp/Software/math_2024/parmetis
make install -C /tmp/Software/math_2024/parmetis

# prereqs for mumps
sudo apt install --no-install-recommends ninja-build libopenmpi-dev openmpi-bin

# install mumps
git clone https://github.com/scivision/mumps.git
cd /tmp/Software/math_2024/mumps
cmake -B build 
cmake --build build 

# compile toolbox
make -C /tmp/Software/math_2024/TOOLBOX_OPTIMIZATION

