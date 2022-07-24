params.index = 'index.csv'
params.outdir = 'results'
process foo {
    publishDir params.outdir, mode:'copy' 
    input:
    tuple val(sampleId), path(read1),path(read2) 

    output:
    path "${sampleId}.out"

    script:
    """
    wc -c $read1 > "${sampleId}.out"
    wc -c $read2 >> "${sampleId}.out"
    """
}

workflow {
    rows_ch = Channel
       .fromPath(params.index)
       .splitCsv(header:true)
       .map{ row-> tuple(row.sampleId, file(row.read1), file(row.read2)) }
    rows_ch.view()
    foo(rows_ch)
}
