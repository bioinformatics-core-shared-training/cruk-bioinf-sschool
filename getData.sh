
##Get example breast cancer data for the first practical

mkdir Day1/nki
wget https://www.dropbox.com/s/82p2dcwwo3qnf21/nki.zip -P Day1/nki
cd Day1/nki
unzip nki.zip
rm nki.zip
cd ../../
##Larger fastq file for QA practical
wget https://www.dropbox.com/s/b8gix98mzlzdrqq/SRR576933.fastq.gz -P Day1/qa


### 1000 Genomes bam for Day 2

samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day2/HG00096.chr22.bam
samtools index Day2/HG00096.chr22.bam
rm HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam.bai

##Extract some of the reads for Day1

samtools sort -n Day2/HG00096.chr22.bam Day2/HG00096.chr22.namesorted
mkdir -p Day/alignment-demo
bamToFastq -i Day2/HG00096.chr22.namesorted.bam -fq Day1//alignment-demo/test.reads_1.fq -fq2 Day1//alignment-demo/test.reads_2.fq
rm Day2/HG00096.chr22.namesorted.bam

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

rm *.tar *.zip

###Get chromosome 22 fasa

cd ../ref_data
wget http://hgdownload-test.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr22.fa.gz
gunzip chr22.fa.gz

##Build bwa and bowtie indices
mkdir bwa
ln -s $(pwd)/chr22.fa bwa/
bwa index bwa/chr22.fa

mkdir bowtie

../Software/bowtie2-2.2.5/bowtie2-build chr22.fa bowtie/chr22

cd ..

