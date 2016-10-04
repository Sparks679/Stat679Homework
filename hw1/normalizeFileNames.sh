#Change file names to include a starting zero
#Usage: bash normalizeFileNames.sh one_or_more_filenames
file="log/timetest$i"
for i in {1..9};
do
	mv log/timetest${i}_snaq.log log/timetest0${i}_snaq.log
	mv out/timetest${i}_snaq.out out/timetest0${i}_snaq.out
done
