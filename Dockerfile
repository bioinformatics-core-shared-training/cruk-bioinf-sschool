
FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>


RUN apt-get update && apt-get install -y git samtools tophat sra-toolkit pkg-config
###Get repository of the course. Install data and R packages
RUN git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git /home/rstudio/
WORKDIR /home/rstudio
RUN samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day2/HG00096.chr22.bam
RUN samtools index Day2/HG00096.chr22.bam
RUN rm HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam.bai
RUN mkdir Day1/nki

RUN rm -r img stylesheets params.json index.html
RUN wget https://www.dropbox.com/s/82p2dcwwo3qnf21/nki.zip -P Day1/nki
WORKDIR Day1/nki
RUN unzip nki.zip
RUN rm nki.zip
WORKDIR /home/rstudio
RUN R -f installBiocPkgs.R
RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip -P /tmp/
WORKDIR Software
RUN unzip fastqc_v0.11.3.zip
RUN chmod 755 /tmp/FastQC/fastqc
RUN ln -s /tmp/FastQC/fastqc /usr/bin/fastqc

###Compile fastx-toolkit; http://hannonlab.cshl.edu/fastx_toolkit/install_ubuntu.txt

WORKDIR Software
RUN wget https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz
RUN gunzip libgtextutils-0.7.tar.gz
RUN tar -xvf libgtextutils-0.7.tar
RUN cd libgtextutils-0.7
RUN ./configure
RUN make
RUN sudo make install
WORKDIR ../

RUN wget http://cancan.cshl.edu/labmembers/gordon/files/fastx_toolkit-0.0.14.tar.bz2 
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
