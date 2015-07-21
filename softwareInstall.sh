###Get repository of the course.
#git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git
sudo apt-get install -y git samtools tophat sra-toolkit pkg-config bwa wget bedtools python-dev r-base

##Download required R packages. Assumes R 3.2.0
R -f installBiocPkgs.R




#### Get and compile fastx toolkit

wget https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz
gunzip libgtextutils-0.7.tar.gz
tar -xvf libgtextutils-0.7.tar
cd libgtextutils-0.7
./configure
make
sudo make install
cd ../

wget http://cancan.cshl.edu/labmembers/gordon/files/fastx_toolkit-0.0.14.tar.bz2 
tar -xjf fastx_toolkit-0.0.14.tar.bz2 
cd fastx_toolkit-0.0.14
./configure
make
sudo make install

##tidy-up 
rm *.zip
rim *.tar

wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install cython
sudo pip install cutadapt
sudo pip install Numpy
sudo pip install MACS2
rm get-pip.py

## Finally, RStudio

wget https://download1.rstudio.org/rstudio-0.99.467-amd64.deb

sudo dpkg -i rstudio-0.99.467-amd64.deb
