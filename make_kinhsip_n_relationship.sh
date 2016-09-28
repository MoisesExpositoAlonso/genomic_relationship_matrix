#!/bin/bash

# Uncomment below if you have the 1001 genomes vcf file
##Transform vcf to plink (this also adds some filters)
#plink --memory 32000 --vcf 1001genomes.vcf --maf 0.001 --mind 0.9 --geno 0.1 --make-bed --out 1001_i09g01_maf0019
## generate tab form from binary plink (you need both)
#plink --bfile 1001_i09g01_maf0019 --recode --tab --out 1001_i09g01_maf0019


plinkfile="1001_i09g01_maf0019" # You need to specify the file name. To make sure it runs correctly, better have this file in the same directory as the bash script and R scripts.

#### Plink version (Relationship matrix rangin 0 to  2)
echo "running plink to compute relationship matrix ..."
plink  --memory 32000 --file $plinkfile --make-rel --out $plinkfile
echo "the relationship matrix file is:", $plinkfile".rel"
echo "the column names of the relationship matrix file is:", $plinkfile".rel.id"

# to make something readable in R
awk '{print $1}' $plinkfile".rel.id" | tr "\n" "\t" > $plinkfile"relmat_2R.txt"
echo "\n" >> $plinkfile"relmat_2R.txt"
cat $plinkfile".rel" >> $plinkfile"relmat_2R.txt"

Rscript read_relmat.R $plinkfile"relmat_2R.txt" # this generates an RData object with the matrix ready to use. Then in another script you just have to load an object.

##### Emmax version (Kinship matrix ranging 0 to 1. to transform to Relationship matrix multiply by two)
outplink="1001gtoemmax"

echo "running emmax to compute the kinship matrix ..."
plink --memory 32000 -bfile $plinkfile --output-missing-genotype 0 --recode transpose 12  --out $outplink
#emmax-kin -v -h -s -d 10 $outplink
echo "the kinship matrix file is:", $outplink".hIBS.kinf"

Rscript read_kinship.R $outplink".hIBS.kinf" # this is going to produce an RData object with the kinship matrix. In this case we do not have the rownames but they are the same order as in the plink .fam file
