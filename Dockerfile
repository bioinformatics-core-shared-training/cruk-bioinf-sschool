
FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>

#Get the latest version of the course materials

##
##Get version 1.1 of samtools
##
RUN wget http://sourceforge.net/projects/samtools/files/samtools/1.1/samtools-1.1.tar.bz2 -P /tmp
WORKDIR /tmp/
RUN bzip2 -d samtools-1.1.tar.bz2
RUN tar xvf samtools-1.1.tar
WORKDIR samtools-1.1
RUN make prefix=/usr/ install
##
## Get fastqc
##
RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.2.zip -P /tmp
WORKDIR /tmp/
RUN unzip fastqc_v0.11.2.zip
RUN chmod 755 FastQC/fastqc
RUN sudo ln -s /tmp/FastQC/fastqc /usr/local/bin/fastqc

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/jts/bam2fastq.git

###Get repository of the course. Install data and R packages
RUN git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git /home/rstudio/
WORKDIR /home/rstudio/cruk-bioinf-sschool
RUN ls
RUN chmod 755 getData.sh
RUN ./getData.sh 
RUN R -f installBiocPkgs.R
