include { INDEX } from './sample5.nf'

process QUANTIFICATION {
     
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

workflow {
  Channel 
    .fromFilePairs( params.reads, checkIfExists:true )
    .set { read_pairs_ch } 
  index_ch = INDEX(params.transcriptome_file)
  QUANTIFICATION(index_ch, read_pairs_ch)
}
