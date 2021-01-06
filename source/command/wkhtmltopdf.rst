.. code:: powershell

  wkhtmltopdf.exe --debug-javascript --javascript-delay 2000 --run-script "document.getElementsByClassName('rst-footer-buttons')[0].innerHTML = ''" https://compare-intel-kunpeng.readthedocs.io/zh_CN/latest/ compare.pdf
