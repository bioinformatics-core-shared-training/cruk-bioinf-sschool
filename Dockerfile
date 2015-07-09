
FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>


RUN apt-get update && apt-get install -y git samtools
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

