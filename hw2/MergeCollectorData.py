#!/usr/bin/env python
"""module to format and merge csv files based on matching dates"""

import argparse #argument parser to create script arguments
import sys
import re #module for extended regular expressions
parser = argparse.ArgumentParser() #define arguements for command line
group = parser.add_argument_group('output arguments')
parser.add_argument("temperaturefile", type=str, help="input file with temperature data")
parser.add_argument("energyfile", type=str, help="input file with energy data")
group.add_argument("-outfile", help="output file; must be in .csv format; defaults to sys.stdout")
group.add_argument("-writeout", help="writing option for output file; a=append, w=overwrite; defaults to 'a'", 
choices=('w', 'a'))
args = parser.parse_args()

def Format_and_Merge(temperaturefile, energyfile, outfile = None, writeout = "a"):
    """reads and formats temperature and energy csv files to lists; merges lists at nearest date; 
    Writes to csv output file;
    Assumes both files are sorted by ascending date and dates overlap between files"""

    if not outfile:
        fout = sys.stdout #sets default output as stdout
    else:
        fout = open(outfile, writeout)

    with open(temperaturefile,"r") as fh: #open water temperature file as a file object 
        temperature = list(filter(None, (fh.read().splitlines()[3:])))
        #read each line into a list and strip the newline character, omitting the header and removing empty strings

    temptimes = []
    for record in temperature:
        assert type(record)==str, "temperature variable must be list of strings" #checks for proper data type
        temptimes.append(re.sub(r'(\d+)/(\d+)/(\d+)', r'20\3-\1-\2', record)) 
        #modify dates to match date format in energy file and append to a new list

    with open(energyfile,"r") as fh: #open energy file as a file object 
        energy = fh.read().splitlines()[1:-2] # read each line and strip the newline character, omitting the header and footer
    assert type(energy[0])==str, "energy variable must be list of strings" #checks for proper data type
    energytimes = list(filter(None, ([times.split(',')[0] for times in energy]))) 
    #split strings in $energy list at "," and keep time values; remove empty strings; shortened with list comprehension
    energyWh = list(filter(None, ([Wh.split(',')[-1] for Wh in energy]))) 
    #split strings in $energy at "," and keep Wh values; remove empty strings

    t=0 #set value that will be used to index lists
    fout.write("RecordNum,Date Time,Temp(°F),Energy(Wh)\n") #write header in $outfile
    for time in temptimes: 
        energydate = (re.search(r'\d+-\d+-\d+', energytimes[t]).group(0)) #define dates in $energytimes list as $energydate
        tempdate = (re.search(r'\d+-\d+-\d+', time).group(0)) #define dates in temptimes list as $tempdate
        assert tempdate >= energydate, "data are not sorted or do not overlap" 
        #checks that dates in $energytimes and $temptimes overlap
        if tempdate == energydate: 
            fout.write("\n") 
            #ensures that different $temptimes strings will appear on separate lines when $tempdate == $energydate is true consecutively
            fout.write(time) #write current $temptime string
            fout.write(",") # write comma to ensure that $energyWh appears in new column when $tempdate > $energydate becomes Ture
        elif tempdate > energydate: #$tempdate changes when this becomes True
            fout.write(energyWh[t+1]) #write $energyWh string at index[t] to the existing line
            fout.write("/1000") #divides $energyWh string by 1000; division is not actually resolved since $energyWh is a string
            fout.write("\n") #writes a newline
            fout.write(time) #writes the first $temptimes string at the new $tempdate
            t = t+1 #changes $energydate so that $tempdate == $energydate is true; changes the index of $energyWh
    return

if __name__ == '__main__': #map command line arguements to function arguements
   Format_and_Merge(*sys.argv[1:])
