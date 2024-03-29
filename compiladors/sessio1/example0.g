#header 
<< #include "charptr.h" >>

<<
#include "charptr.c"

int main() {
   ANTLR(expr(), stdin);
}
>>

#lexclass START
#token NUM "[0-9]+"
#token PLUS "\+"
#token MINUS "\-"
#token SPACE "[\ \n]" << zzskip(); >>

input: expr "@" ;
//expr: NUM (PLUS NUM)* ;
expr: NUM (MINUS NUM)* ;

//expr: expr PLUS expr | NUM;
//expr: NUM PLUS expr | NUM;