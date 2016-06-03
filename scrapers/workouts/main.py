#!/usr/bin/env python
# -*- coding: utf-8 -*- 
import os
import urllib2
import csv
from bs4 import BeautifulSoup # To get everything
import re
import pprint
import time
import json

# muscle and strength base url
BASE_URL = "https://www.muscleandstrength.com"

class SoupParser:

  def __init__(self): 
    # Scrape an external 
    # req = urllib2.Request("https://www.muscleandstrength.com/workouts/muscle-building")
    # req.add_header("User-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    # res = urllib2.urlopen(req)
    self.ptPage = open("muscle_strength.txt", "r").read()
    self.data = BeautifulSoup(self.ptPage, "html.parser")
    container = self.data.find("div", { "class": "view-display-id-block_4" })
    url_list = []
    sub_container = container.find("div", {"class" : "view-content"})
    for anchor_tag in sub_container.findAll("div", {"class" : "item"}):
      url = anchor_tag.find("a")['href']
      url_list.append(url)
      self.parse_fitness_programs(BASE_URL + url)
    
    print len(url_list)
    self.fileHandle =  open("muscle_and_fitness_urls.txt", "w")
    self.fileHandle.write(str(url_list))

  def parse_fitness_programs(self, url):
    dic = {}
    req = urllib2.Request(url)
    req.add_header("User-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    res = urllib2.urlopen(req)
    
    dd = BeautifulSoup(res, "html.parser")
    header = dd.find("h1")
    dic['Title'] = str(header.string)
    print str(header.string)
    summary_container = dd.find("div", { "class": "workoutSummary" })
    summary_sub_container = summary_container.find("div", { "class": "data-wrap" })
    with open('names.csv', 'a') as csvfile:
      fieldnames = ['Title', 'Main Goal ', 'Author ', 'Days Per Week ', 'Equipment Required ', 'Workout Type ', 'Training Level ', 'Target Gender ', 'Summary', 'Image']
      writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
      for item in summary_sub_container.findAll("div", {"class" : "row"}):
          label = str(item.find("label").string)
          field = str(item.find("label").next_sibling.string)
          dic[label] = field
      
      # Workout Table
      # table = dd.find("table")
      # if table is not None or table is not None:

      # Summary
      summary = dd.find("div", { "class": "nodeSummary"})
      if summary is not None:
        summary_contents = summary.find("div", { "class": "even"})
        if summary_contents is not None:
          dic["Summary"] = summary_contents.string.encode('utf-8')

      # Workout Image
      image_container = dd.find("div", { "class": "feature-image"})
      if image_container is not None:
        image = image_container.find("img")
        if image is not None:
          dic["Image"] = image["src"].encode('utf-8')

      # Write to CSV file
      writer.writerow(dic)

      # Write to text file
      desc = open("phul-workout-contents.txt", "a")
      desc.write(json.dumps(dic, indent=2))
    
if __name__ == "__main__":
    s = SoupParser()
