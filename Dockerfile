
FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>


RUN apt-get update && apt-get install -y git samtools sra-toolkit pkg-config bwa bedtools python-dev r-base
###Get repository of the course. Install data and R packages
RUN git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git /home/rstudio/
WORKDIR /home/rstudio
RUN chmod 755 getData.sh
RUN ./getData.sh
RUN R -f installBiocPkgs.R
RUN chmod 755 softwareInstall.sh
RUN ./softwareInstall

RUN rm -r img stylesheets params.json img

WORKDIR /home/rstudio
