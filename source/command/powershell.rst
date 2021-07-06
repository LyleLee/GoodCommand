###################
PowerShell
###################

获取当前文件夹的文件名，最后更新时间，创建时间，所有者

.. code:: powershell

    Get-ChildItem -path . | select name,lastwritetime,CreationTime,@{Name="Owner";Expression={(Get-ACL $_.Fullname).Owner}}
