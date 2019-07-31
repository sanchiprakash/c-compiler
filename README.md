# c-compiler
This is a simple Mini C Compiler using Lex & Yacc.It also has a very basic ui.


Compilation Steps-

    1)cd c-compiler
    2)cd bin
    3)node www
    4)Hit localhost:3000/ and enter your c-code(The first line contains number of lines in the input c code)   
    5)Click Submit


Alernate Compilation Steps-

    1)cd c-compiler
    2)cd bin
  	3)lex new.l
  	4)yacc -d new.y
  	5)gcc y.tab.c -ll -ly
  	6)./a.out [Text-file name to input ]

Sample testcase-test.txt
