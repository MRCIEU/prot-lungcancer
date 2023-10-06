# DNA nexus analysis

docker build -t plinkbgen .

docker pull biocontainers/bcftools:v1.9-1-deb_cv1


```bash
for i in {1..22}
do
i=21
docker run \
    -v $(pwd):/proj \
    -v /mnt/project/Bulk/Imputation/Imputation\ from\ genotype\ \(TOPmed\)/helper_files/:/data \
    biocontainers/bcftools:v1.9-1-deb_cv1 \
    /proj/variant_selection.sh ${i}
done
```


docker run \
    -v $(pwd):/proj \
    -v /mnt/project/Bulk/Imputation/Imputation\ from\ genotype\ \(TOPmed\)/:/data \
    plink \
    plink2 --bgen /data/ukb21007_c21_b0_v1.bgen ref-first --sample /proj/extract/temp.sample --extract /proj/extract/keep_21.txt --make-bed --out /proj/extract/ext21

docker run \
    -v $(pwd):/proj \
    -v /mnt/project/Bulk/Imputation/Imputation\ from\ genotype\ \(TOPmed\)/:/data \
    bgen \
    bgenix -g /data/ukb21007_c21_b0_v1.bgen -incl-rsids /proj/extract/keep21.txt -og /proj/extract/temp.txt.gz

wget https://www.well.ox.ac.uk/~gav/resources/qctool_v2.2.0-CentOS_Linux7.8.2003-x86_64.tgz
tar xzvf qctool_v2.2.0-CentOS_Linux7.8.2003-x86_64.tgz
mv qctool_v2.2.0-CentOS\ Linux7.8.2003-x86_64/qctool .
rm -r qctool_v2.2.0-CentOS*

./qctool -g /mnt/project/Bulk/Imputation/Imputation\ from\ genotype\ \(TOPmed\)/ukb21007_c21_b0_v1.bgen -og extract/temp21.bgen -incl-rsids extract/keep_21.txt

./qctool -g /mnt/project/Bulk/Imputation/Imputation\ from\ genotype\ \(GEL\)/ukb21008_c21_b0_v1.bgen -og ~/extract/temp21.bgen -incl-rsids ~/extract/keep_21.txt

./qctool -g /mnt/project/Bulk/Imputation/UKB\ imputation\ from\ genotype/ukb22828_c21_b0_v3.bgen -og ~/extract/temp21.bgen -incl-rsids ~/extract/keep_21.txt


./qctool -g /mnt/project/Bulk/Imputation/UKB\ imputation\ from\ genotype/ukb22828_c21_b0_v3.bgen -og ~/extract/temp21.bgen -incl-rsids ~/extract/keep_21.txt

./qctool -g /mnt/project/Bulk/Imputation/UKB\ imputation\ from\ genotype/ukb22828_c21_b0_v3.bgen -og extract/temp21.bgen -s /mnt/project/Bulk/Imputation/UKB\ imputation\ from\ genotype/ukb22828_c21_b0_v3.sample -incl-samples extract/idlist.txt

sed 1d /mnt/project/mdd-prs/data.csv | cut -d "," -f 1 > extract/prot_idlist.txt

sed 's/0 0 0 0/0 0 0 D/1' /mnt/project/Bulk/Imputation/Imputation\ from\ genotype\ \(TOPmed\)/ukb21007_c21_b0_v1.sample > extract/temp.sample

./qctool -g /mnt/project/Bulk/Imputation/Imputation\ from\ genotype\ \(TOPmed\)/ukb21007_c21_b0_v1.bgen -og extract/temp21.bgen -s extract/temp.sample -incl-samples extract/idlist.txt




```