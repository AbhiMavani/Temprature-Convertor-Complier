# Temprature-Convertor-Complier
This Project is based on Language translator. Project has a compiler to check syntax , evaluate it and generate the output. If syntax is correct then it will genetare output according yo user's input otherwise it will tells the error.

Use :
First compile lex file using flex tool.
  $flex temprature.l
It will generate lex.yy.c file
 
Second .y file using yacc tool or bison tool.
  $bison -dy temprature.y
IT will generate y.tab.c and y.tab.h file.

Third :
  $gcc lex.yy.c y.tab.c

Fourth :
  $a.exe
