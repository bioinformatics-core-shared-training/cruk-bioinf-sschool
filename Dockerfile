
FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>


RUN sudo apt-get install -y git samtools tophat  sra-toolkit pkg-config bwa wget bedtools python-dev libedit2
###Get repository of the course. Install data and R packages
RUN git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git /home/rstudio/
WORKDIR /home/rstudio
RUN chmod 755 softwareInstall.sh
RUN ./softwareInstall.sh
RUN chmod 755 getData.sh
RUN ./getData.sh

RUN rm -r img stylesheets params.json img

WORKDIR /home/rstudio
