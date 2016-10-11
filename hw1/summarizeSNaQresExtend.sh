#!/bin/bash
#set -e # script terminates if any command exits with non-zero status
#set -u # terminates if any variable is unset
#set -o pipefail # terminates if command within a pipes exits unsuccessfully
#Tabulate results of SNaQ analyses
#Utilize: bash summarizeSNaQres.sh one_or_more_filenames
echo -e "analysis,h,CPUtime,Nruns,Nfail,fabs,frel,xtabs,xrel,seed,under3460,under3450,under3440\n" > SNaQSummary.csv
for logfile in log/*.log
do
	Root=$(basename -s .log $logfile) #Define rootname as variable $Root
	Hmax=$(sed -rn 's/hmax = ([0-9])+./\1/p' $logfile)
	outfile=out/$Root.out #Define outfile location based on $Root
	Time=$(sed -rn 's/Elapsed time: ([0-9]+\.[0-9]+) [a-z].+/\1/p' $outfile)
	Nruns=$(sed -rn 's/.+ ([0-9]+) runs .+/\1/p' $logfile)
	Nfail=$(sed -rn 's/.* failed proposals = ([0-9]+).+/\1/p' $logfile)
	fabs=$(sed -rn 's/.+ ftolAbs=([0-9]+\..*[0-9])./\1/p' $logfile)
	frel=$(sed -rn 's/.+ ftolRel=([0-9]+\.[0-9]+e*-*[0-9]*).+/\1/p' $logfile)
	xtabs=$(sed -rn 's/.+ xtolAbs=([0-9]+\..+[0-9]).+ .+/\1/p' $logfile)
	xrel=$(sed -rn 's/.+ xtolRel=([0-9]+\..*[0-9]+).+/\1/p' $logfile)
	seed=$(sed -rn 's/main seed ([0-9]+)/\1/p' $logfile)
	loglik=$(sed -rn 's/.+loglik=([0-9]+)\..*/\1/p' $logfile)
	u3460=0
	u3450=0
	u3440=0
	for score in $loglik
        do
                if [ $score -ge 3460 ]
                then
                 :
                else
                        if [ $score -ge 3450 ]
                        then
                         ((u3460++))
                        else
                                if [ $score -ge 3440 ]
                                then
                                 ((++u3450))
                                else
                                 ((++u3440))
                fi
                        fi
                                fi
	done
	echo -e "$Root","$Hmax","$Time","$Nruns","$Nfail","$fabs","$frel","$xtabs","$xrel","$seed","$u3460","$u3450","$u3440" >> SNaQSummary.csv #Push values to csv file
done

