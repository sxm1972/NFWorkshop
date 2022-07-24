params.reads = "$baseDir/data/ggal/gut_{1,2}.fq"
params.transcript = "$baseDir/data/ggal/transcriptome.fa"
params.multiqc = "$baseDir/multiqc"
params.outdir = "results"
/*
 * define the `index` process that creates a binary index
 * given the transcriptome file
 */
process INDEX {
  publishDir params.outdir, mode:'copy'     
  input:
  path transcriptome

  output:
  path 'salmon_index'

  script:
  """
  salmon index --threads $task.cpus -t $transcriptome -i salmon_index
  """
}

process QUANTIFICATION {
    publishDir params.outdir, mode:'copy'     
    input:
    path index 
    tuple val(pair_id), path(reads) 
 
    output:
    path(pair_id) 
 
    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}

process FASTQC {
    tag "FASTQC on $sample_id"

    input:
    tuple val(sample_id), path(reads) 

    output:
    path("fastqc_${sample_id}_logs") 

    script:
    """
    mkdir fastqc_${sample_id}_logs
    fastqc -o fastqc_${sample_id}_logs -f fastq -q ${reads}
    """  
}  
workflow {
  Channel 
    .fromFilePairs( params.reads, checkIfExists:true )
    .set { read_pairs_ch } 
  index_ch = INDEX(params.transcript)
  QUANTIFICATION(index_ch, read_pairs_ch)
  FASTQC(read_pairs_ch)
}
