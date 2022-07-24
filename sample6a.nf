
params.reads = "$baseDir/data/ggal/gut_{1,2}.fq"

Channel.fromFilePairs(params.reads).set {read_pairs_ch} 
read_pairs_ch.view()

