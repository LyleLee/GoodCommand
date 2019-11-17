# coding=utf-8
#!/usr/bin/python3

import urllib.request
import bs4
import time

url = r'https://www.zhihu.com/question/353381490'
headers = "{'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36'}"

#req = urllib.request.Request(url=url,headers=headers)
res = urllib.request.urlopen(url)
html = res.read().decode('utf-8')
soup = bs4.BeautifulSoup(html, 'html.parser')
title = soup.select('div.QuestionHeader-main > h1')[0].string
view = soup.find_all("strong", class_="NumberBoard-itemValue")
viewer = view[0].string
viewTimes = view[1].string
today_now = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

print(f"{title} 时间：{today_now}  关注者:{viewer} 被浏览量：{viewTimes}")
