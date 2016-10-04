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


```Unix Shell
    file="log/timetest$i" #define location of target files
    for i in {1..9}; #defines variable range
        do
        mv log/timetest${i}_snaq.log log/timetest0${i}_snaq.log #change name and delete original file with mv 
        mv out/timetest${i}_snaq.out out/timetest0${i}_snaq.out
    done

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
```Unix Shell
    echo -e "analysis,h,CPUtime\n" > SNaQSummary.csv #Push table header to .csv file
    for logfile in log/*.log;
        do
        Root="$(grep root $logfile | grep -o "\w+\d.+")" #Define rootname as result of grep pipeline; grep -o for word with digits and special character 
        Hmax="$(grep "hmax =" $logfile | grep -o '\d+')" #Define hmax as result of grep pipeline; grep -o for digits only
        outfile="out/"$Root".out" #define *.out location from $Root variable
        Time="$(grep Elapsed "$outfile" | grep -o '[d+\.\d+')" #Define hmax as result of grep pipeline; grep -o for digits and special character
        echo -e "$Root","$Hmax","$Time" >> SNaQSummary.csv #Append rootname, hmax, elapsed time values to .csv file
    done

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

Completion Pending
