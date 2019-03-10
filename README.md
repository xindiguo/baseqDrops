# baseqDrops
A versatile pipeline for processing dataset from 10X, indrop and Drop-seq.

See the [beiseq/baseqDrops](https://github.com/beiseq/baseqDrops) for details

## System requirement
for efficient processing

* memory >= 30Gb 
* CPU cores >=8 

## How to use
+ Download the reference genome from https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest and store in `data/reference`
+ Create the configuration file: `./create_config <genome> <container_path_to_reference_genome>`
+ Start the container with `docker run -v "$(pwd)"/data:/usr/app/data --name <container_name> -it <image_name>`
