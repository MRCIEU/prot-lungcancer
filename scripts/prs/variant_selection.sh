#!/bin/bash
i=${1}
mkdir -p /proj/extract
bcftools view -i 'INFO/AF > 0.01 & INFO/AF < 0.99 & INFO/R2 > 0.8' /data/ukb21007_c${i}_b0_v1.sites.vcf.gz | bcftools query -f "%ID\n" > /proj/extract/keep${i}.txt
