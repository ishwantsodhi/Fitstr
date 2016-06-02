#!/usr/bin/env python
# -*- coding: utf-8 -*- 
import os
import urllib2
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
      url_list.append(anchor_tag.find("a")['href'])
    
    print len(url_list)
    self.fileHandle =  open("muscle_and_fitness_urls.txt", "w")
    self.fileHandle.write(str(url_list))
    # Count number of postings parsed
    self.count = 0
    self.locationCount = 0


if __name__ == "__main__":
    s = SoupParser()