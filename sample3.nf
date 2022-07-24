
process doThis {
    input:
	    val num
    output:
       path "${num}.txt" 
    """
    echo "$num" > ${num}.txt
    """
}

process doThat {
    input:
	    file mynumfile 
    output:
        stdout

    """
    cat $mynumfile
    """
}
workflow {
    doThat(doThis(Channel.from(1,2,3))).subscribe{println it}
}

