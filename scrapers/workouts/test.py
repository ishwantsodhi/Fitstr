# -*- coding: utf-8 -*- 
import os
import urllib2
import csv
import re
import pprint
import time
import json

class CleanUp:

    def __init__(self):
        print 'Starting...'
        
    def read_csv(self, file):
        dic = {}
        with open('names.csv', 'rb') as csvfile:
            reader = csv.reader(file)
            
            for row in reader:
                print ', '.join(row)
                
            

if __name__ == "__main__":
    c = CleanUp()
    # c.read_csv('names.csv')
    with open('names.csv', 'rb') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
        for row in spamreader:
            print ', '.join(row)