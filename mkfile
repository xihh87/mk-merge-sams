MERGE_SORT_TARGETS=`{./targets_mergesams}

merge_sort_sams:V:	$MERGE_SORT_TARGETS

'../results/(.*/)?(.*)\.merged\.bam':RD:		'../results/\1'
	mkdir -p `dirname $target`
	FILES_TO_MERGE="`find $prereq -name $stem2'_nt.*.bam'`"
	samtools merge \
		-c \
		-p \
		$target \
		$FILES_TO_MERGE

../results/%.merged_sorted.sam:	../results/%.merged.bam
	mkdir -p `dirname $target`
	samtools sort \
		-n \
		-o $target \
		$prereq
