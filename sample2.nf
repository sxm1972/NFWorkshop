num = Channel.from(1,2,3)
process doThis {
    input:
	val num
    output:
       path "${num}.txt" 
    """
    echo "$num" > ${num}.txt
    """
}

workflow {
    genomes = doThis(num)
    genomes.view()
}

