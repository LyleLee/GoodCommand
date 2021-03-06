=======================
Regex
=======================

正则表达式


.. code:: text

  .       - Any Character Except New Line
  \d      - Digit (0-9)
  \D      - Not a Digit (0-9)
  \w      - Word Character (a-z, A-Z, 0-9, _)
  \W      - Not a Word Character
  \s      - Whitespace (space, tab, newline)
  \S      - Not Whitespace (space, tab, newline)

  \b      - Word Boundary
  \B      - Not a Word Boundary
  ^       - Beginning of a String
  $       - End of a String

  []      - Matches Characters in brackets
  [^ ]    - Matches Characters NOT in brackets
  |       - Either Or
  ( )     - Group

  Quantifiers:
  *       - 0 or More
  +       - 1 or More
  ?       - 0 or One
  {3}     - Exact Number
  {3,4}   - Range of Numbers (Minimum, Maximum)


  #### Sample Regexs ####

  [a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]
  
  
from https://raw.githubusercontent.com/CoreyMSchafer/code_snippets/master/Regular-Expressions/snippets.txt
  
youtube: https://www.youtube.com/watch?v=sa-TUpSx1JA&list=WL&index=2&ab_channel=CoreySchafer
 
use in notepad++ http://shouce.jb51.net/notepad_book/npp_func_regex_replace.html

