import pandas as pd
import requests
import json
import csv
import time
import datetime
import sys

def getpushshiftData(after, before):
    url = 'https://api.pushshift.io/reddit/search/comment/?after='+str(after)+'&before='+str(before)+'&fields=body,created_utc,author&sort=asc&size=100'
    print(url)
    r = requests.get(url)
    data = json.loads(r.text)
    return data['data']

def collectComData(comm):
    commData = list()
    comment = comm['body']
    author = comm['author']
    created = datetime.datetime.fromtimestamp(comm['created_utc'])

    commData.append((author, comment, created))
    commStats[author] = commData

after = 1483250400
before = 1514700000
commCount = 0
commStats = {}

while True:
    try:
        data = getpushshiftData(after, before)
        if len(data) > 0:
            for comment in data:
                collectComData(comment)
                commCount += 1

            print(len(data))
            print(str(datetime.datetime.fromtimestamp(data[-1]['created_utc'])))
            after = data[-1]['created_utc'] + 86400
            print(after)
        else:
            print("No more data, breaking out now...")
            break
    except:
        print("Exception occurred! Skipping...")
        after = data[-1]['created_utc'] + 86400
        print(after)
    

print(len(data))

def updateCommFile():
    uploadCount = 0
    location = 'C:\\Users\\KIIT\\Dropbox\\My PC (BT1000111998)\\Documents\\.Python\\2017.csv'
    filename = location
    file = filename
    with open(file, 'w', newline = '', encoding = 'UTF-8') as file:
        a = csv.writer(file, delimiter = ',')
        headers = ['author', 'comment', 'created']
        a.writerow(headers)
        for comm in commStats:
            a.writerow(commStats[comm][0])
            uploadCount += 1

updateCommFile()
