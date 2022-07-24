params.reads = "$baseDir/data/*_R{1,2}_xxx.fastq.gz"

read_pairs_ch = Channel.fromFilePairs(params.reads)

read_pairs_ch.view()
