check() {
	if [[ "$a" -ne "$b" ]]; then
		echo " <ERROR!>"
	else
		echo " <OK!>"
	fi
}
  
go build

_N=0
show() {
	_N=$(($_N+1))
	echo ""
	echo -n "<## TEST.$_N ##>" $1
}


./vcfanno -js example/custom.js example/conf.toml example/fitcons.bed > obs
show "annotated bed"
check $(wc -l < example/fitcons.bed) $(wc -l < obs)


./vcfanno -js example/custom.js example/conf.toml example/query.vcf > obs
show "annotated vcf"
check $(grep -cv ^# example/query.vcf) $(grep -cv ^# obs)

rm -f obs
