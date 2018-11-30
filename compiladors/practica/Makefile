file  = chatbots
flags = -I /usr/include/pccts
Wno   = -Wno-write-strings

all: $(file)

executed:
	antlr -gt $(file).g
	dlg -ci parser.dlg scan.c
	g++ $(Wno) $(flags) -o $(file) $(file).c scan.c err.c
	rm -f *.o *.c parser.dlg *.h
	./$(file)

$(file):
	antlr -gt $(file).g
	dlg -ci parser.dlg scan.c
	g++ $(Wno) $(flags) -o $(file) $(file).c scan.c err.c
	rm -f *.o *.c parser.dlg *.h
	./$(file) < ex0.txt > a.out
	rm -f $(file)
	cat a.out
clean:
	rm -f $(file)
