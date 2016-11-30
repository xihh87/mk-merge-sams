MERGE_SORT_TARGETS=`{./targets_mergesams}

merge_sort_sams:V:	$MERGE_SORT_TARGETS

'results/(.*/)?(.*)\.merged\.bam':RD:		'data/\1'
	mkdir -p `dirname $target`
	dir=$prereq
	prefix=$stem2
	FILES_TO_MERGE="`find $dir -name $prefix'_nt.*.bam'`"
	samtools merge \
		-c \
		-p \
		$target \
		$FILES_TO_MERGE

results/%.merged_sorted.sam:	results/%.merged.bam
	mkdir -p `dirname $target`
	samtools sort \
		-n \
		-o $target \
		$prereq
