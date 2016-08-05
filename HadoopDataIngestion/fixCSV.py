#!/usr/bin/python
#fixCSV.py
#This script reads in a csv and outputs the csv with escaped commas.
#IN:     "no comma","contains, a comma",,"previous is null","","previous is empty"
#OUT:    no comma,contains\, a comma,,previous is null,,previous is empty
#Usage ~/fixCSV.py ~/some/input.csv ~/some/output.csv

import csv
import sys

#open files
inFile = open(sys.argv[1], 'rb') 
outFile  = open(sys.argv[2], "wb")

try:

    reader = csv.reader(inFile)
    writer = csv.writer(outFile, quoting=csv.QUOTE_NONE,escapechar='\\',lineterminator='\n')
    for row in reader:
        #print row
        writer.writerow(row)
finally:
    #close files
    inFile.close()
    outFile.close()


