# coding = utf-8
# !/usr/bin/python3

import urllib.request
import sys
import bs4
import random
from time import sleep

print(sys.getdefaultencoding())

urlPool = {

    '163':    'https://www.163.com/',
    'bilibili': 'https://www.bilibili.com/ranking',
    'qqnews': 'https://news.qq.com/',
    'qqv': 'https://v.qq.com/',
    'xinhua': 'http://www.xinhuanet.com/',
    'zhihu': 'https://www.zhihu.com/billboard',
    'tophub': 'https://tophub.today/',
    'tianya': 'https://bbs.tianya.cn/',
    'sina' : 'https://tech.sina.com.cn/'
}

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
                         'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36',
           'Accept-Encoding': ''}

for key, value in urlPool.items():
    with open(f'{key}.html', 'w+', encoding='utf-8') as pageFile:
        req = urllib.request.Request(url=value, headers=headers)
        res = urllib.request.urlopen(req)
        httpCode = res.getcode()
        charset = res.headers.get_content_charset()
        charset = charset if charset is not None else 'utf-8'
        html = res.read().decode(charset)
        # soup = bs4.BeautifulSoup(html, 'html.parser')
        # for link in soup.findAll('img'):
        #    print("IMAGE LINKS:", link.get('src'))
        pageFile.write(html)
        print(f'visit:{key} {httpCode} {charset} url:{value} write successful')
        sleep(random.randint(0, 15))
