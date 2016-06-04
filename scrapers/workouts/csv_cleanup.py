#!/usr/bin/env python
# -*- coding: utf-8 -*- 
import os
import urllib2
import csv
import re
import pprint
import time
import json
import sys

class CleanUp:

    def __init__(self):
        print 'Starting...'
    
    def create_id_dict(self, infile):
        dic = {}
        with open(infile, 'rb') as infile:
            reader = csv.reader(infile)
            count = 0
            title_list = next(reader)
            for i in range(len(title_list)):
                if title_list[i] == 'equipment array': 
                    position = i 
                    break
            
            eq_count = 1
            for row in reader:
                equipments = row[position].split(', ')
                for equipment in equipments:
                    if equipment not in dic:
                        dic[equipment] = eq_count
                        eq_count += 1
        return dic                
    
    def replace_eq_id_csv(self, infile, outfile, dic):
        with open(infile, 'rb') as infile, open(outfile, 'wb') as outfile:
            r = csv.reader(infile)
            next(r)
            w = csv.writer(outfile)
            for row in r:
                equipment_ids = []
                temp = row[4]
                equipments = temp.split(', ')
                for equipment in equipments:
                    if equipment in dic:
                        equipment_ids.append(dic[equipment]) 
                row[4] = equipment_ids
                w.writerow(row)

if __name__ == "__main__":
    c = CleanUp()
    dic = c.create_id_dict('mas_popular_muscle_building_194.csv')
    c.replace_eq_id_csv('mas_popular_muscle_building_194.csv', 'fit_programs.csv', dic)
    pprint.pprint(dic, width=1)