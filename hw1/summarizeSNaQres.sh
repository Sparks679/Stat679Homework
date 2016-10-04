#Tabulate results of SNaQ analyses
#Utilize: bash summarizeSNaQres.sh one_or_more_filenames
echo -e "analysis,h,CPUtime\n" > SNaQSummary.csv
for logfile in log/*.log;
do
	Root="$(grep root $logfile | grep -o "\w*[0-9].*")"
	Hmax="$(grep "hmax =" $logfile | grep -o '[0-9]')"
	outfile="out/"$Root".out"
	Time="$(grep Elapsed "$outfile" | grep -o '[0-9]*\.[0-9]*')"
	echo -e "$Root","$Hmax","$Time" >> SNaQSummary.csv
done
