merge_sort_sams:V:	$MERGE_SORT_TARGETS
	./targets | xargs mk

'results(.*/)(.*)\.merged\.sam':RD:		'data\1'
	mkdir -p `dirname $target`
	dir=$prereq
	prefix=$stem2
	seq_file='results/'$prefix'.list'
	find "$dir" -name "$prefix"'_nt.*.bam' > "$seq_file"
	cat "$seq_file" \
	| xargs -l samtools view \
	> "$target"'.build' \
	&& mv "$target"'.build' "$target"

results/%.merged_sorted.sam:	results/%.merged.sam
	mkdir -p `dirname $target`
	samtools sort \
		-n \
		$prereq
	> "$target"'.build' \
	&& mv "$target"'.build' "$target"
