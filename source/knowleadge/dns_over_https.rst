dns over https
==============

经由https进行dns解析。 一般情况下，
访问一个网站，需要使用url提交给dns服务器，
dns服务器返回url对应的ip地址。浏览器使用该IP获取网站内容。这个dns解析过程一般是明文传输的，
也就是说ISP可以很清楚地知道你访问了，www.12306.com还是www.123xxx.com。

使用dns over https之后，
url被加密了，没人知道你访问了什么网站虽然IP地址还是知道的。

设置方式是：

https://www.zdnet.com/article/how-to-enable-dns-over-https-doh-in-google-chrome/
