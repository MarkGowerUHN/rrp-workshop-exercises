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

#create the fastq directory
mkdir -p $fastq_dir

###Obtain and "process" the R1 fastq file
echo "Obtaining $fastq_r1" # this is going to print the fastq r1 filename

#Download the file
# the -O flag keeps the original internet file name
curl -O $fastq_url/$fastq_r1 
curl -O $fastq_url/$fastq_r2

# Explore the file: How many lines?
echo "The number of lines in $fastq_r1 is...drumroll....."
gunzip -c $fastq_r1 | wc -l 
echo "The number of lines in $fastq_r2 is...drumroll....."
gunzip -c $fastq_r2 | wc -l

#move the fastq file to the correct directory
mv $fastq_r1 $fastq_dir
mv $fastq_r2 $fastq_dir




