file  = chatbots
Wno   = -Wno-write-strings
c11   = -std=c++11

all: $(file)

executed:
	antlr -gt $(file).g
	dlg -ci parser.dlg scan.c
	g++ $(Wno) $(c11) -o $(file) $(file).c scan.c err.c
	rm -f *.o *.c parser.dlg *.h
	./$(file)
	rm $(file)

$(file):
	antlr -gt $(file).g
	dlg -ci parser.dlg scan.c
	g++ $(Wno) $(c11) -o $(file) $(file).c scan.c err.c
	rm -f *.o *.c parser.dlg *.h
	./$(file) < ex0.txt > a.out
	rm -f $(file)
	cat a.out
clean:
	rm -f $(file)
