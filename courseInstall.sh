###Get repository of the course.
git clone https://github.com/bioinformatics-core-shared-training/cruk-bioinf-sschool.git

cd cruk-bioinf-sschool
##Get example data for sequencing practicals
wget https://www.dropbox.com/s/ve6o68hkbthe3lo/exampleData.zip
unzip exampleData.zip

##Download required R packages. Assumes R 3.2.0
R -f installBioCPkgs.R
##Remove some files that came from git 
rm -r images javascripts stylesheets params.json index.html exampleData.zip

##Put example data in the right place
mkdir Day2/exampleData
mv exampleData/* Day2/exampleData
rm -r exampleData/

##Get example breast cancer data for the first practical and put in Practicals folder
mkdir Day1/nki
wget https://www.dropbox.com/s/82p2dcwwo3qnf21/nki.zip -P Day1/nki
cd Day1/nki
unzip nki.zip
rm nki.zip
