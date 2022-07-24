
params.reads = "$baseDir/data/ggal/gut_{1,2}.fq"

read_pairs_ch = Channel.fromFilePairs(params.reads)
read_pairs_ch.view()

