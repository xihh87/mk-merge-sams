< merge.mk

merge_sort_sams:V:	$MERGE_SORT_TARGETS
	./targets | xargs mk

'results/%.list':
	mkdir -p `dirname "$target"`
	prefix=`basename "$stem" .list`
	dir=`dirname 'data/'"$stem"`
	find -L "$dir" -name "$prefix"'_nt.*.bam' \
	| sort -V \
	> "$target"'.build' \
	&& mv "$target"'.build' "$target"

'results(.*/)(.*)\.merged\.sam':RD:		'data\1'	'results/\2\.list'
	mkdir -p `dirname "$target"`
	dir=$prereq
	prefix=$stem2
	seq_file='results/'$prefix'.list'
	cat "$seq_file" \
	| ./combine-headers \
	> "$target"'.build'
	cat "$NT_REFERENCE"'.sequences' \
	>> "$target"'.build'
	cat "$seq_file" \
	| xargs -l samtools view \
	>> "$target"'.build' \
	&& mv "$target"'.build' "$target"

results/%.merged.bam:	results/%.merged.sam
	samtools view \
		-b \
		-T $NT_REFERENCE \
		"$prereq" \
	> "$target"'.build' \
	&& mv "$target"'.build' "$target" \
	&& rm "$prereq"
