# c-compiler
This is a simple Mini C Compiler using Lex & Yacc.It also has a very basic ui.

Compilation Steps-
  cd c-compiler
  cd bin
  node www
  Hit localhost:3000/ and enter your c-code(The first line contains number of lines in the input)   
  Click Submit

Alernate Compilation Steps-
  cd c-compiler
  cd bin
	lex new.l
	yacc -d new.y
	gcc y.tab.c -ll -ly
	./a.out [Text-file name to input ]

Sample testcase-test.txt
