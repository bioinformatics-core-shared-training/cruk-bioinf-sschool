###Get repository of the course.
git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git

cd cruk-bioinf-sschool
##Get example data for sequencing practicals

samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day2/HG00096.chr22.bam
samtools index Day2/HG00096.chr22.bam
 


##Download required R packages. Assumes R 3.2.0
R -f installBioCPkgs.R
##Remove some files that came from git 
rm -r images img javascripts stylesheets params.json index.html


##Get example breast cancer data for the first practical and put in Practicals folder
mkdir Day1/nki
wget https://www.dropbox.com/s/82p2dcwwo3qnf21/nki.zip -P Day1/nki
cd Day1/nki
unzip nki.zip
rm nki.zip


# samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > HG00096.chr22.bam
# samtools index HG00096.chr22.bam