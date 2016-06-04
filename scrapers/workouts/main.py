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
    print 'Starting...'

  # Scrap entire HTML webpages for a source
  def scrape_web_pages(self, urls, type):
    # Scrape an external webpage
    c = 0
    for url in urls:
      name = url.split('.')[1]
      req = urllib2.Request(url)
      req.add_header("User-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
      res = urllib2.urlopen(req)    
      parsed_web_page = BeautifulSoup(res, "html.parser")
      file = open(name + str(c) + type + ".txt", "a")
      file.write(str(parsed_web_page))
      c+=1

  # Scrap program urls from a webpage
  def scrape_program_urls(self, file_name, webpage_url, type, c):
    text = open(file_name + str(c) + type + ".txt", "r").read()
    data = BeautifulSoup(text, "html.parser")
    container = data.find("div", { "class": "view-display-id-block_3" })
    url_list = []
    sub_container = container.find("div", {"class" : "view-content"})
    for anchor_tag in sub_container.findAll("div", {"class" : "item"}):
      url = anchor_tag.find("a")['href']
      url_list.append(url)
      self.parse_fitness_programs(BASE_URL + url)
    print len(url_list)
    self.fileHandle = open(file_name + str(c) + "muscle_and_fitness_urls.txt", "w")
    self.fileHandle.write(str(url_list))

  def parse_fitness_programs(self, url):
    dic = {}
    req = urllib2.Request(url)
    req.add_header("User-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    res = urllib2.urlopen(req)
    
    dd = BeautifulSoup(res, "html.parser")
    header = dd.find("h1")
    dic['Title'] = str(header.string.encode('utf-8'))
    print str(header.string.encode('utf-8'))
    summary_container = dd.find("div", { "class": "workoutSummary" })
    summary_sub_container = summary_container.find("div", { "class": "data-wrap" })
    # with open('mas_popular_muscle_build_194.csv', 'a') as csvfile:
    with open('mas_popular_fat_loss.csv', 'a') as csvfile:
      fieldnames = [
      'Title', 'Main Goal ', 'Author ',
      'Days Per Week ', 'Equipment Required ',
      'Workout Type ', 'Training Level ',
      'Target Gender ', 'Summary', 'Image',
      'Shares', 'Stars', 'Votes', 'Comments']
      writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
      for item in summary_sub_container.findAll("div", {"class" : "row"}):
        label = str(item.find("label").string)
        field = str(item.find("label").next_sibling.string.encode('utf-8'))
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

      # shares
      shares_container = dd.find("div", { "class": "share-count"})
      shares = shares_container.find("span", { "class": "count"})
      if shares is not None:
        dic["Shares"] = shares.string

      # star count
      stars_container = dd.find("div", { "class": "count-container one"})
      stars = stars_container.find("span", { "class": "star-count"})
      if stars is not None:
        dic["Stars"] = stars.string

      # star count
      votes_container = dd.find("div", { "class": "count-container two"})
      votes = votes_container.find("span", { "class": "star-count"})
      if votes is not None:
        if (votes.string[-1] == 'K' or votes.string[-1] == 'k'):
          dic["Votes"] = str(int(float(votes.string[:-1]) * 1000))
        else:
          dic["Votes"] = votes.string

      # comment count
      comments_container = dd.find("h3", { "class": "blueStripe"})
      comments = comments_container.find("span").previous_sibling.string      
      if comments is not None:
        comment_c = comments.string.split(" Comments")[0]
        if (comment_c[-1] == 'K' or comment_c[-1] == 'k'):
          print comment_c
          dic["Comments"] = str(int(float(comment_c[:-1]) * 1000))
        else:
          dic["Comments"] = comment_c

      if image_container is not None:
        image = image_container.find("img")
        if image is not None:
          dic["Image"] = image["src"].encode('utf-8')


      # Write to CSV file
      writer.writerow(dic)

      # Write to text file
      # desc = open("mas_popular_muscle_build.txt", "a")
      desc = open("mas_popular_fat_loss.txt", "a")
      desc.write(json.dumps(dic, indent=2))
    
if __name__ == "__main__":
    s = SoupParser()
    mas_muscle_building_urls = [
      "https://www.muscleandstrength.com/workouts/muscle-building?tid=38&did=3",
      "https://www.muscleandstrength.com/workouts/muscle-building?page=1&tid=38&did=3",
      "https://www.muscleandstrength.com/workouts/muscle-building?page=2&tid=38&did=3",
      "https://www.muscleandstrength.com/workouts/muscle-building?page=3&tid=38&did=3"
    ]

    mas_fat_loss_urls = [
      "https://www.muscleandstrength.com/workouts/fat-loss?tid=41&did=3",
      "https://www.muscleandstrength.com/workouts/fat-loss?page=1&tid=41&did=3"
    ]


    # s.scrape_web_pages(mas_fat_loss_urls, "fat_loss")
    c = 0
    for webpage_url in mas_fat_loss_urls:  
      s.scrape_program_urls("muscleandstrength", webpage_url, "fat_loss", c)
      c += 1
