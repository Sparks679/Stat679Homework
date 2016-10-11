**Stat679: Homework 1**
=================

Storage of Shell Scripts used to complete *Homework 1* by *Sparks679*

===========
**Exercise 1**
===========

-----------
Prerequisites
------------

/bin/bash

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

mv# moves file contents and deletes original
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

/bin/bash

GNU Unix assumed
#BSD users will have different arguements to enable extended regular expressions

*.log files can be found at /home/sparks/coursework/hw1-snaqTimeTests/log/    
*.out files found in /home/sparks/coursework/hw1-snaqTimeTests/out/    


--------
Built With
---------

Nano

---
Code
---

summarizeSNaQfiles.sh
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

#$Root= rootname of logfile
#$Hmax= hmax value fro logfile
#$outfile= location of *.out file
#Time= CPUtime value from outfile
#grep -P '\d+' = extended regex finding numbers with one or more digits
## -P enables extended regex for GNU grep; -E for BSD grep
#echo= print target
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

bash summarizeSNaQfiles.sh

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

bin/bash

GNU Unix assumed
#BSD users will have different arguements to enable extended regular expressions

*.log files can be found at /home/sparks/coursework/hw1-snaqTimeTests/log/
*.out files found in /home/sparks/coursework/hw1-snaqTimeTests/out/


--------
Built With
---------

Nano

----
Code
----

#logfile= location of *.logfile
#$Root= rootname of logfile
#$Hmax= hmax value from logfile
#$outfile= location of *.out file
#$Time= CPUtime value from outfile
#$Nruns= number of runs from logfile
#$Nfail= number of failed attempts from logfile
#$fabs= ftolAbs tolerance parameter from logfile
#$frel= ftolRel tolerance parameter from logfile
#$xtabs= xtolAbs tolerance parameter from logfile
#$xrel= xtolRel tolerance parameter from logfile
#$seed= main seed value from logfile
#$loglik= variable containing values of all network scores within a single logfile
##$score= variable containing a single network score value from $loglike; used to run each network score individually through if statement 
#$u3460= number of network scores under 3460 for a given logfile
#$u3450= number of network scores under 3450 for a given logfile
#$u3440= number of network score under 3440 for a given logfile
#sed -rn 's/pattern/replacement/p'= search for <pattern> and replace with <replacement>; print if match is found
## -r enables the use of extended regex for GNU sed; -E for BSD sed
#echo= print target
------
Purpose
------

#Find file rootname, hmax, elapsed time, number of runs, number of failed attempts, main seed, tolerance parameters, and network score (loglikelihood) values and display results as table in .csv file

----------------
Original Location
----------------

/home/sparks/coursedata/hw1-snaqTimeTests


------
Execute
------

bash summarizeSNaQfilesExtend.sh

------
Authors
------
K. William Sparks

--------
Original Date Created
-------
2016-10-08
