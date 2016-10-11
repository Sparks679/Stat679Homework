#!/bin/bash
set -e # script terminates if any command exits with non-zero status
set -u # terminates if any variable is unset
set -o pipefail # terminates if command within a pipes exits unsuccessfully
#Tabulate results of SNaQ analyses
#Utilize: bash summarizeSNaQres.sh one_or_more_filenames
echo -e "analysis,h,CPUtime,Nruns,Nfail,fabs,frel,xtabs,xrel,seed,under3460,under3450,under3440\n" > SNaQSummary.csv #add column titles to .csv file
for logfile in log/*.log
do
	Root=$(basename -s .log $logfile) #Define rootname as variable $Root
	Hmax=$(sed -rn 's/hmax = ([0-9])+./\1/p' $logfile) #Define hmax value as variable $Hmax
	outfile=out/$Root.out #Define outfile location based on $Root
	Time=$(sed -rn 's/Elapsed time: ([0-9]+\.[0-9]+) [a-z].+/\1/p' $outfile) #Define Elapsed time value as variable $Time
	Nruns=$(sed -rn 's/.+ ([0-9]+) runs .+/\1/p' $logfile) #Define number of runs as variable $Nruns
	Nfail=$(sed -rn 's/.* failed proposals = ([0-9]+).+/\1/p' $logfile) #Define number of failed proposals as variable $Nfail
	fabs=$(sed -rn 's/.+ ftolAbs=([0-9]+\..*[0-9])./\1/p' $logfile) #Define ftolAbs value as variable $fabs
	frel=$(sed -rn 's/.+ ftolRel=([0-9]+\.[0-9]+e*-*[0-9]*).+/\1/p' $logfile) #Define ftolRel value as variable $frel
	xtabs=$(sed -rn 's/.+ xtolAbs=([0-9]+\..+[0-9]).+ .+/\1/p' $logfile) #Define xtolAbs value as variable $xtabs
	xrel=$(sed -rn 's/.+ xtolRel=([0-9]+\..*[0-9]+).+/\1/p' $logfile) #Define xtolRel value as variable $xrel
	seed=$(sed -rn 's/main seed ([0-9]+)/\1/p' $logfile) #Define main seed values as variable $seed
	loglik=$(sed -rn 's/.+loglik=([0-9]+)\..*/\1/p' $logfile) #Define set of values in each $logfile as variable $loglik
	u3460=0 #set number of scores under 3460 to 0
	u3450=0 #set number of scores under 3450 to 0
	u3440=0 #set number of scores under 3440 to 0
        for score in $loglik #Define individual values within $loglik as variable $score
        do
                if [ $score -ge 3460 ] #set values of $u3460, $u3450, $u3440 with nested if statement
                then
                 :
                else
                        if [ $score -ge 3450 ]
                        then
                         ((++u3460))
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
	echo -e "$Root","$Hmax","$Time","$Nruns","$Nfail","$fabs","$frel","$xtabs","$xrel","$seed","$u3460","$u3450","$u3440" >> SNaQSummary.csv #Append values to csv file
done

