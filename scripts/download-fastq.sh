#!/bin/bash

#This will terminate the script if we get an error, o has to be last
#this is called error handling

set -euo pipefail

# Set the working directory to this files working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

#"Constant" variables
study_id="SRP255885"
fastq_url="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR115/089/SRR11518889"

# Define files and directories
fastq_r1="SRR11518889_1.fastq.gz"
fastq_r2="SRR11518889_2.fastq.gz"
fastq_dir="../data/raw/fastq/$study_id"
trim_dir="../data/trimmed/$study_id"
reports_dir="../reports/fastp"

#create the fastq directory
mkdir -p $fastq_dir $trim_dir $reports_dir

###Obtain and "process" the R1 fastq file
echo "Obtaining $fastq_r1" # this is going to print the fastq r1 filename
if [ ! -f "$fastq_dir/$fastq_r1" ]; then
#Download the file
# the -O flag keeps the original internet file name
	curl -O $fastq_url/$fastq_r1 
fi

echo "Obtaining $fastq_r2" # this is going to print the fastq r2 filename
if [ ! -f "$fastq_dir/$fastq_r2" ]; then

	curl -O $fastq_url/$fastq_r2
fi

# Explore the file: How many lines?
#echo "The number of lines in $fastq_r1 is...drumroll....."
#gunzip -c $fastq_dir/$fastq_r1 | wc -l 
#echo "The number of lines in $fastq_r2 is...drumroll....."
#gunzip -c $fastq_dir/$fastq_r2 | wc -l

#move the fastq files to the correct directory
#mv $fastq_r1 $fastq_dir
#mv $fastq_r2 $fastq_dir


fastp \
	--in1 $fastq_dir/$fastq_r1 \
	--in2 $fastq_dir/$fastq_r2 \
	--out1 $trim_dir/$fastq_r1 \
	--out2 $trim_dir/$fastq_r2 \
	--html "$reports_dir/${study_id}_report.html"


