##############################
JavaScript
##############################

动态插入外部JavaScript代码

.. code:: javascript

    var script=document.createElement("script");  
    script.type="text/javascript";  
    script.src="http://www.microsoftTranslator.com/ajax/v3/WidgetV3.ashx?siteData=ueOIGRSKkd965FeEGM5JtQ**";  
    document.getElementsByTagName('head')[0].appendChild(script);  

作者：GitLqr
链接：https://juejin.cn/post/6844903496274198542
来源：掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
