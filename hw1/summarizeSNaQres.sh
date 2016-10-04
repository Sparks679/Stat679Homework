#Tabulate results of SNaQ analyses
#Utilize: bash summarizeSNaQres.sh one_or_more_filenames
echo -e "analysis,h,CPUtime\n" > SNaQSummary.csv
for logfile in log/*.log;
do
	Root="$(grep root $logfile | grep -Po "\w+\d.*")"
	Hmax="$(grep "hmax =" $logfile | grep -Po '\d+')"
	outfile="out/"$Root".out"
	Time="$(grep Elapsed "$outfile" | grep -Po '\d+\.\d+')"
	echo -e "$Root","$Hmax","$Time" >> SNaQSummary.csv
done
