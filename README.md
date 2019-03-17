# baseqDrops
A versatile pipeline for processing dataset from 10X, indrop and Drop-seq.

See the [beiseq/baseqDrops](https://github.com/beiseq/baseqDrops) for details

## System requirement
for efficient processing

* memory >= 30Gb 
* CPU cores >=8 

## How to use
### Before starting the container
+ Desigante a folder for storing data files that will be mounted to the container, i.e. folder `data`
  ```
  mkdir data
  cd data
  ```
+ Download and unzip the reference genome from [here](https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest)
  ```
  # Curerent References - 3.0.0 (November 19, 2018)
  # Example - Human reference (GRCh38) 
  mkdir reference
  wget http://cf.10xgenomics.com/supp/cell-exp/refdata-cellranger-GRCh38-3.0.0.tar.gz
  tar xvzf refdata-cellranger-GRCh38-3.0.0.tar.gz
  ```
+ Create the configuration file: `./create_config <genome> <container_path_to_reference_genome>`
  ```
  # Example
  ./create_config hg38 data/reference/refdata-cellranger-GRCh38-3.0.0
  mv config_drop.ini data/
  ```
### Run with volume 
  ```
  docker pull guoxindi/baseqdrops
  # Example 
  docker run -v "$(pwd)"/data:/usr/app/data -it baseqdrops run-pipe --config data/config_drop.ini -g hg38 -p 10X -n 10X_sample -1 data/input/10X_R1.fastq.gz -2 data/input/10X_R2.fastq.gz -d data/output
  ```
  See [beiseq/baseqDrops](https://github.com/beiseq/baseqDrops) for details.
