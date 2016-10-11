#!/bin/bash
set -e # script terminates if any command exits with non-zero status
set -u # terminates if any variable is unset
set -o pipefail # terminates if command within a pipes exits unsuccessfully
#Tabulate results of SNaQ analyses
#Utilize: bash summarizeSNaQres.sh one_or_more_filenames
echo -e "analysis,h,CPUtime,Nruns,Nfail,fabs,frel,xtabs,xrel,seed,under3460,under3450,under3440\n" > SNaQSummary.csv
for logfile in log/*.log;
do
	Root="$(grep root $logfile | grep -Po "\w+\d.*")" #Define rootname as variable $Root
	basename -s .log $(logfile) #Define rootname as variable $Root
	Hmax="$(grep "hmax =" $logfile | grep -Po '\d+')" #Define hmax value as variable $Hmax
	outfile="out/"$Root".out" #Define outfile location based on $Root
	Time="$(grep Elapsed "$outfile" | grep -Po '\d+\.\d+')" #Define CPU time value as variable $Time
	echo -e "$Root","$Hmax","$Time" >> SNaQSummary.csv #Push values to csv file
done
