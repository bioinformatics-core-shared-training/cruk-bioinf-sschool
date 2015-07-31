
FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>

RUN sudo apt-get update
RUN sudo apt-get install -y git samtools tophat sra-toolkit bwa wget bedtools python-dev fastx-toolkit r-cran-rgl
###Get repository of the course. Install data and R packages
RUN git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git /home/rstudio/
WORKDIR /home/rstudio
RUN chmod 755 getData.sh
RUN sudo R -f installBiocPkgs.R
RUN R -f getNKIData.R


#RUN ./getData.sh


RUN mkdir Day1/alignment-demo
WORKDIR Day1/alignment-demo
#RUN wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX%2FSRX483%2FSRX483591/SRR1186252/SRR1186252.sra
#RUN fastq-dump SRR1186252.sra
RUN wget http://training.bio.cam.ac.uk/SRR1186252_trimmed.fq.chr6.fq
RUN wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/chromosomes/chr6.fa.gz
RUN gunzip chr6.fa.gz
RUN mv chr6.fa hg19chr6.fa
WORKDIR  ../../
### 1000 Genomes bam for Day 2

RUN samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day2/HG00096.chr22.bam
RUN samtools index Day2/HG00096.chr22.bam
RUN rm HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam.bai
 
RUN mkdir -p Day2/bam
WORKDIR Day2/bam
#RUN wget http://training.bio.cam.ac.uk/bam.tar.gz
WORKDIR ../../

WORKDIR Software
##Get latest version of bowtie and tophat

RUN wget http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.5/bowtie2-2.2.5-linux-x86_64.zip
RUN unzip bowtie2-2.2.5-linux-x86_64.zip

RUN wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz
RUN gunzip tophat-2.1.0.Linux_x86_64.tar.gz
RUN tar xvf tophat-2.1.0.Linux_x86_64.tar

RUN wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
RUN gunzip cufflinks-2.2.1.Linux_x86_64.tar.gz
RUN tar xvf cufflinks-2.2.1.Linux_x86_64.tar

RUN rm *.tar *.zip

###Get chromosome 22 fasa

WORKDIR ../ref_data
RUN wget http://hgdownload-test.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr22.fa.gz
RUN gunzip chr22.fa.gz

##Build bwa and bowtie indices
RUN mkdir bwa
RUN ln -s $(pwd)/chr22.fa bwa/
RUN bwa index bwa/chr22.fa

RUN mkdir bowtie

#RUN ../Software/bowtie2-2.2.5/bowtie2-build chr22.fa bowtie/chr22

#RUN mkdir whole_genome
#WORKDIR  whole_genome
#RUN wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz
#RUN mkdir bwa
#RUN mkdir bowtie
#RUN ln -s $(pwd)/human_g1k_v37.fasta.gz bwa/
#RUN bwa index -p hg19 bwa/human_g1k_v37.fasta.gz
#RUN ../../Software/bowtie2-2.2.5/bowtie2-build human_g1k_v37.fasta.gz bowtie/hg19

WORKDIR  ../..

WORKDIR /home/rstudio/Software
RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip
RUN unzip fastqc_v0.11.3.zip
RUN sudo chmod 755 FastQC/fastqc
RUN ln -s $(pwd)/FastQC/fastqc /usr/bin/fastqc
#RUN rm -r img stylesheets params.json img
RUN rm fastqc_v0.11.3.zip
RUN wget http://downloads.sourceforge.net/project/samstat/samstat-1.5.1.tar.gz
RUN gunzip samstat-1.5.1.tar.gz
RUN tar -xvf samstat-1.5.1.tar
WORKDIR samstat-1.5.1
RUN ./configure
RUN sudo make install


RUN wget https://bootstrap.pypa.io/get-pip.py
RUN sudo python get-pip.py
RUN sudo pip install cython
RUN sudo pip install --user --upgrade cutadapt
RUN sudo pip install Numpy
RUN sudo pip install MACS2
RUN sudo chmod 755 /usr/local/bin/macs2
RUN rm get-pip.py
RUN sudo apt-get install -y openjdk-7-jdk
#Get two of the bam files that we can use for counting example
WORKDIR Day2/bam
RUN wget http://training.bio.cam.ac.uk/cruk/16N_aligned.bam
RUN wget http://training.bio.cam.ac.uk/cruk/16N_aligned.bam.bai
RUN wget http://training.bio.cam.ac.uk/cruk/16T_aligned.bam
RUN wget http://training.bio.cam.ac.uk/cruk/16T_aligned.bam.bai

WORKDIR /home/rstudio

