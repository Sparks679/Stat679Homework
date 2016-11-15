**Stat679: Homework 2**
=================

Storage of Python script used to complete *Homework 2* by *Sparks679

-----------
Prerequisites
------------

Python 3.5.2 :: Anaconda 4.2.0 (64-bit)

*.csv file containing water data

*.csv file containing temperature data

executable permission for MergeCollectorData.py


--------
Built With
---------

Nano

Python 3.5.2 :: Anaconda 4.2.0 (64-bit)

Jupyter Lab


----
Code
----

MergeCollectorData.py

```python
#!/usr/bin/env python
"""module to format and merge csv files based on matching dates"""

import argparse #argument parser to create script arguments
import sys
import re #module for extended regular expressions
parser = argparse.ArgumentParser() #define arguements for command line
parser.add_argument("temperaturefile", type=str, help="input file with temperature data")
parser.add_argument("energyfile", type=str, help="input file with energy data")
parser.add_argument("outfile", nargs='?', help="output file; defaults to sys.stdout")
parser.add_argument("writeout", nargs='?', help="writing option for output file; defaults to 'a'")
args = parser.parse_args()

def Format_and_Merge(temperaturefile, energyfile, outfile = None, writeout = "a"):
    """reads and formats temperature and energy csv files to lists; merges lists at n
    Writes to csv output file;
    Assumes both files are sorted by ascending date and dates overlap between files"""

   if not outfile:
        fout = sys.stdout #sets default output as stdout
    else:
        fout = open(outfile, writeout)

    with open(temperaturefile,"r") as fh: #open water temperature file as a file object
        temperature = list(filter(None, (fh.read().splitlines()[3:]))) #read each line; strip newline character; omit empty strings and header

    temptimes = []
    for record in temperature:
       assert type(record)==str, "temperature variable must be list of strings" #check for correct data type
        temptimes.append(re.sub(r'(\d+)/(\d+)/(\d+)', r'20\3-\1-\2', record)) #modify dates to match dates in $energytimes

    with open(energyfile,"r") as fh: #open energy file as a file object 
        energy = fh.read().splitlines()[1:-2] # read each line and strip the newline; omit header and footer
    assert type(energy[0])==str, "energy variable must be list of strings" #checks for correct data type
    energytimes = list(filter(None, ([times.split(',')[0] for times in energy]))) #split sting, keeping time and date; omit empty strings
    energyWh = list(filter(None, ([Wh.split(',')[-1] for Wh in energy]))) #split string, keeping Wh value; omit empty strings

    t=0 #set value that will be used to index lists
    fout.write("RecordNum,Date Time,Temp(°F),Energy(Wh)\n") #write header in $outfile
    for time in temptimes: 
        energydate = (re.search(r'\d+-\d+-\d+', energytimes[t]).group(0)) #define dates in $energytimes
        tempdate = (re.search(r'\d+-\d+-\d+', time).group(0)) #define dates in $temptimes
        assert tempdate >= energydate, "data are not sorted or do not overlap" #check that dates are sorted and overlap between files
        if tempdate == energydate: 
            fout.write("\n") #ensures that different $temptimes strings will appear on separate lines when $tempdate == $energydate is true consecutively 
            fout.write(time) #write current $temptime string
            fout.write(",") # write comma to ensure that $energyWh appears in new column
        elif tempdate > energydate: #$tempdate changes when this becomes True
            fout.write(energyWh[t+1]) #write $energyWh string at index[t+1] to the existing line
            fout.write("/1000") #divides $energyWh string by 1000; division is not resolved because $energyWh[t] is a string
            fout.write("\n") #writes a newline
            fout.write(time) #writes the first $temptimes string at the new $tempdate
            t = t+1 #changes $energydate so that $tempdate == $energydate is true; changes index of $energyWh[t]
    return

if __name__ == '__main__': #map command line arguements to function arguements
   Format_and_Merge(*sys.argv[1:])
```


---------------
List of Functions
---------------
argparse = module that creates and documents command line arguments

re = module that uses extended regular expressions

open with(target file, w/r/a) as file object = opens target file as a file object for reading (r), writing (w), or appending (a)

read().striplines() = removes newline (\n) characters from the line being read

list(filter(None, list))) removes empty strings from list

re.search('regex string', list) = searches for target regular expression in target list of strings

list.append('') = appends string values to list

fileobject.readlines() = read each line of a file open as a file object

fileobject.write("") = write string to a file open as a file object

------------
List of Arguments
-------------

temperaturefile = .csv file containing temperature data; specify path

energyfile = .csv file containing energy data; specify path

outfile = output file; must be .csv; defaults to sys.stdout

writeout = choose either 'a' to append outfile or 'w' to overwrite outfile


 
------
Purpose
------

Format and merge two .csv files at matching time intervals

------
Execute
------
#!/usr/bin/env python


python MergeCollectorData.py temperaturefile energyfile outfile writeout

or

./MergeCollectorData.py temperaturefile energyfile outfile writeout

# use python MergeCollectorData.py -h to see arguments


------
Authors
------

K. William Sparks

--------
Original Date Created
-------

2016-11-14
