**Stat679: Homework 1**
=================

Storage of Shell Scripts used to complete *Homework 1* by *Sparks679*

===========
**Exercise 1**
===========

-----------
Prerequisites
------------

* /bin/bash

*.log files found at /home/sparks/coursedata/hw1-snaqTimeTests

*.out files found at /home/sparks/coursedata/hw1-snaqTimeTests

--------
Built With
---------

Nano

---
Code
---

normalizefilenames.sh


```Bash
    file="log/timetest$i" #define location of target files
    for i in {1..9}; #defines variable range
        do
        mv log/timetest${i}_snaq.log log/timetest0${i}_snaq.log #change name and delete original file with mv 
        mv out/timetest${i}_snaq.out out/timetest0${i}_snaq.out
    done
```
---------------------
Commands and Variables
---------------------

* mv= moves file contents and deletes original

-----
Purpose
-----

Change filenames to include leading zero

----------------
Original Location
----------------

/home/sparks/coursedata/hw1-snaqTimeTests

------
Execute
------

bash normalizefilenames.sh

-----
Authors
-----

K. William Sparks

=========
**Exercise 2**
=========

------------
Prerequisites
------------

* /bin/bash

* GNU Unix assumed
 * BSD users will have different arguements to enable extended regular expressions

*.log files can be found at /home/sparks/coursework/hw1-snaqTimeTests/log/
    
*.out files found in /home/sparks/coursework/hw1-snaqTimeTests/out/    


--------
Built With
---------

Nano

---
Code
---

summarizeSNaQres.sh
```Bash
    echo -e "analysis,h,CPUtime\n" > SNaQSummary.csv #Push table header to .csv file
    for logfile in log/*.log;
        do
        Root="$(grep root $logfile | grep -Po "\w+\d.+")" #Define rootname as result of grep pipeline; grep -o for word with digits and special character 
        Hmax="$(grep "hmax =" $logfile | grep -Po '\d+')" #Define hmax as result of grep pipeline; grep -o for digits only
        outfile="out/"$Root".out" #define *.out location from $Root variable
        Time="$(grep Elapsed "$outfile" | grep -Po '[d+\.\d+')" #Define hmax as result of grep pipeline; grep -o for digits and special character
        echo -e "$Root","$Hmax","$Time" >> SNaQSummary.csv #Append rootname, hmax, elapsed time values to .csv file
    done
```

---------------------
Commands and Variables
---------------------

* $Root= rootname of logfile
* $Hmax= hmax value fro logfile
* $outfile= location of *.out file
* Time= CPUtime value from outfile
* grep -P '\d+' = extended regex finding numbers with one or more digits
 * -P enables extended regex for GNU grep; -E for BSD grep
* echo= print target

------
Purpose
------

Find file rootname, hmax, and elapsed time values and display results as table in .csv file

----------------
Original Location
----------------

/home/sparks/coursedata/hw1-snaqTimeTests


------
Execute
------

bash summarizeSNaQres.sh

------
Authors
------

K. William Sparks


==========
**Exercise 3**
==========

------------
Prerequisites
------------

* /bin/bash

* GNU Unix assumed
 * BSD users will have different arguements to enable extended regular expressions

*.log files can be found at /home/sparks/coursework/hw1-snaqTimeTests/log/

*.out files found in /home/sparks/coursework/hw1-snaqTimeTests/out/


--------
Built With
---------

Nano

----
Code
----

summarizeSNaQresExtend.sh

```bash
	echo -e "analysis,h,CPUtime,Nruns,Nfail,fabs,frel,xtabs,xrel,seed,under3460,under3450,under3440\n" > SNaQSummary.csv #add column titles to .cs$
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
		echo -e "$Root","$Hmax","$Time","$Nruns","$Nfail","$fabs","$frel","$xtabs","$xrel","$seed","$u3460","$u3450","$u3440" >> SNaQSummary.c$
	done
```

--------------------
Commands and Variables
--------------------

* $logfile= location of *.logfile
* $Root= rootname of logfile
* $Hmax= hmax value from logfile
* $outfile= location of *.out file
* $Time= CPUtime value from outfile
* $Nruns= number of runs from logfile
* $Nfail= number of failed proposals from logfile
* $fabs= ftolAbs tolerance parameter from logfile
* $frel= ftolRel tolerance parameter from logfile
* $xtabs= xtolAbs tolerance parameter from logfile
* $xrel= xtolRel tolerance parameter from logfile
* $seed= main seed value from logfile
* $loglik= variable containing values of all network scores within a single logfile
* $score= variable containing a single network score value from $loglike; used to run each network score individually through if statement 
* $u3460= number of network scores under 3460 for a given logfile
* $u3450= number of network scores under 3450 for a given logfile
* $u3440= number of network score under 3440 for a given logfile
* sed -rn 's/pattern/replacement/p'= search for <pattern> and replace with <replacement>; print if match is found
 * -r enables the use of extended regex for GNU sed; -E for BSD sed
* echo= print target

------
Purpose
------

Find file rootname, hmax, elapsed time, number of runs, number of failed attempts, main seed, tolerance parameters, and network score (loglikelihood) values and display results as table in .csv file

----------------
Original Location
----------------

/home/sparks/coursedata/hw1-snaqTimeTests


------
Execute
------

bash summarizeSNaQresExtend.sh

------
Authors
------

K. William Sparks

--------
Original Date Created
-------

2016-10-08
