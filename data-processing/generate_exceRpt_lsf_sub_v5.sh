# generate_exceRpt_lsf_sub_v5.sh
# Dan Spakowicz
# 15 Jan 2017
# This script generates the submission scripts for all of the Chupp data with the dev version
# of the pipeline that generates the rRNA tables

cd /project/fas/gerstein/djs88/chupp/bulkCellRNAseq/fastq/
OUTPATH="/gpfs/home/fas/gerstein/djs88/myscripts/projects/chas/exceRpt_submission/withrRNAtables/moreMem_nthreads20"

for D in `find Sample* -type d ` ; do
     echo '#BSUB -M 96000' >> $OUTPATH/${D}_exceRpt.sh
     echo '#BSUB -R "span[hosts=1]"' >> $OUTPATH/${D}_exceRpt.sh
     echo "#BSUB -n 20" >> $OUTPATH/${D}_exceRpt.sh
     echo "#BSUB -q gerstein" >> $OUTPATH/${D}_exceRpt.sh
     echo "#BSUB -J ${D}" >> $OUTPATH/${D}_exceRpt.sh
     echo "" >> $OUTPATH/${D}_exceRpt.sh
     echo "# Produced by generate_exceRpt_lsf_sub_v5.sh" >> $OUTPATH/${D}_exceRpt.sh
     echo "# Dan Spakowicz" >> $OUTPATH/${D}_exceRpt.sh
     echo "# 15 Jan 2017" >> $OUTPATH/${D}_exceRpt.sh
     echo "# Submission file for bulkRNAseq data on lsf with exceRpt. For v3, there is more memory allocated than in v2 and doesn't delete old versions of files. For v4, a bigmem node with 1tb RAM queue was used and the memory allocated accordingly. This version uses the standard gerstein queue but does so with more threads, which hopefully will fix memory error exiting that occurred with v3." >> $OUTPATH/${D}_exceRpt.sh
     echo "" >> $OUTPATH/${D}_exceRpt.sh
     echo "PIPELINE=/project/fas/gerstein/tg397/exceRpt_longRNA_dev_test_DS/new/exceRpt_longRNA_dev" >> $OUTPATH/${D}_exceRpt.sh
     echo "make -f \$PIPELINE \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            EXE_DIR=/gpfs/scratch/fas/gerstein/rrk24/bin/smallRNAPipeline \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            N_THREADS=20 \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            ADAPTER_SEQ=none \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            OUTPUT_DIR=/project/fas/gerstein/djs88/chupp/bulkCellRNAseq/map_exogenous/Processed \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            MAIN_ORGANISM_GENOME_ID=hg38 \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            MIN_READ_LENGTH=20 \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            MAP_EXOGENOUS=on \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            JAVA_RAM=90G \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            REMOVE_LARGE_INTERMEDIATE_FILES=true \\" >> $OUTPATH/${D}_exceRpt.sh
     echo "            INPUT_FILE_PATH_R1=/project/fas/gerstein/djs88/chupp/bulkCellRNAseq/fastq/${D}/${D}.fq.gz" >> $OUTPATH/${D}_exceRpt.sh ;
done

cd $OUTPATH
chmod u+x *
