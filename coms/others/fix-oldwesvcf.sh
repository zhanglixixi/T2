#!/usr/bin/env bash
author="Yongchu Liu"
version="0.1.1"
created="2020-07-10"
updated="2020-07-10"
usage="
Fix VCF format issue for gatk 3.8 based WES samples. So can be read by bcftools etc.
Version ${version}, updated on ${updated}.

Usage: $(basename $0) outdir sample invcf
"
[[ $# -lt 1 ]] && echo -e "${usage}" && exit 0

outdir=$1
sample=$2
invcf=$3
outfile="${outdir}/${sample}.vcf.gz"

[[ ! -d ${outdir} ]] && mkdir -p ${outdir}

source /qh01/env/anaconda3/bin/activate toolkits2
set -x

cat ${invcf} | awk '{if(NR>=2 && NR<=5) {xx=gensub(/"</,"<",1); yy=gensub(/>"/,">",1,xx); print yy} else print $0;}' \
    | sed '/##INFO=<ID=ABHet/i\##INFO=<ID=AB,Number=1,Type=Float,Description="Allele balance for each het genotype">' \
    | bcftools reheader -s <(echo "${sample}") \
    | bcftools view -o ${outfile} -Oz
bcftools index --tbi ${outfile}
