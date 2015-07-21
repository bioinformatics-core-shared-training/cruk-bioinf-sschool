
FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>


RUN apt-get update && apt-get install -y git samtools sra-toolkit pkg-config bwa bedtools python-dev
###Get repository of the course. Install data and R packages
RUN git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git /home/rstudio/
WORKDIR /home/rstudio
RUN samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day2/HG00096.chr22.bam
RUN samtools index Day2/HG00096.chr22.bam
RUN samtools sort -n Day2/HG00096.chr22.bam Day2/HG00096.chr22.namesorted
RUN rm HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam.bai
RUN bamToFastq -i Day2/HG00096.chr22.namesorted.bam -fq Day1/test.reads_1.fq -fq2 Day1/test.reads_2.fq


RUN mkdir Day1/nki
RUN wget https://www.dropbox.com/s/b8gix98mzlzdrqq/SRR576933.fastq.gz -P Day1


RUN rm -r img stylesheets params.json index.html
RUN wget https://www.dropbox.com/s/82p2dcwwo3qnf21/nki.zip -P Day1/nki
WORKDIR Day1/nki
RUN unzip nki.zip
RUN rm nki.zip


WORKDIR /home/rstudio
RUN R -f installBiocPkgs.R
RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip -P /home/rstudio/Software
WORKDIR Software
RUN unzip fastqc_v0.11.3.zip
RUN chmod 755 /home/rstudio/Software/FastQC/fastqc
RUN ln -s /home/rstudio/Software/FastQC/fastqc /usr/bin/fastqc

###Compile fastx-toolkit; http://hannonlab.cshl.edu/fastx_toolkit/install_ubuntu.txt

RUN wget https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz
RUN gunzip libgtextutils-0.7.tar.gz
RUN tar -xvf libgtextutils-0.7.tar
WORKDIR libgtextutils-0.7
RUN ls
RUN ./configure
RUN make
RUN sudo make install
WORKDIR ../

RUN wget https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2
RUN tar -xjf fastx_toolkit-0.0.14.tar.bz2 
WORKDIR fastx_toolkit-0.0.14
RUN ./configure
RUN make
RUN sudo make install
WORKDIR ../

RUN wget http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.5/bowtie2-2.2.5-linux-x86_64.zip
RUN unzip bowtie2-2.2.5-linux-x86_64.zip

RUN wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz
RUN gunzip tophat-2.1.0.Linux_x86_64.tar.gz
RUN tar xvf tophat-2.1.0.Linux_x86_64.tar

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN sudo python get-pip.py
RUN sudo pip install cython
RUN sudo pip install cutadapt
RUN sudo pip install Numpy
RUN sudo pip install MACS2

RUN rm *.zip
RUN rm *.tar
RUN rm *.tar.bz2

WORKDIR ../ref_data
RUN wget http://hgdownload-test.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr22.fa.gz
RUN gunzip chr22.fa.gz
RUN bwa index chr22.fa

RUN ../Software/bowtie2-2.2.5/bowtie2-build chr22.fa chr22

WORKDIR /home/rstudio
