params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
/*
 * define the `index` process that creates a binary index
 * given the transcriptome file
 */
process INDEX {
  input:
  path transcriptome

  output:
  path 'salmon_index'

  script:
  """
  salmon index --threads $task.cpus -t $transcriptome -i salmon_index
  """
}

workflow {
  index_ch = INDEX(params.transcriptome_file)
}
