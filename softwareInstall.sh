###Get repository of the course.
#git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git
sudo apt-get install -y git samtools tophat sra-toolkit pkg-config bwa wget bedtools python-dev r-base

##Download required R packages. Assumes R 3.2.0
R -f installBiocPkgs.R

cd Software
##Get latest version of bowtie and tophat

wget http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.5/bowtie2-2.2.5-linux-x86_64.zip
unzip bowtie2-2.2.5-linux-x86_64.zip

wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz
gunzip tophat-2.1.0.Linux_x86_64.tar.gz
tar xvf tophat-2.1.0.Linux_x86_64.tar

wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
gunzip cufflinks-2.2.1.Linux_x86_64.tar.gz
tar xvf cufflinks-2.2.1.Linux_x86_64.tar

rm *.tar


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
