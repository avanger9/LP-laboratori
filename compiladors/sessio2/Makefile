flags = -I /usr/include/pccts
file = example1

all: $(file)

$(file):
	antlr -gt $(file).g
	dlg -ci parser.dlg scan.c
	g++ $(flags) -o $(file) $(file).c scan.c err.c
	rm -f *.o scan.c err.c parser.dlg *.h
	./$(file)
clean:
	rm -f $(file)
