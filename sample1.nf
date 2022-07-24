num = Channel.from(1,2,3)

process doThis {
    input:
	val num

    "echo $num"
}

workflow {
    doThis(num)
}

//workflow {
//    my_pipeline()
//}
