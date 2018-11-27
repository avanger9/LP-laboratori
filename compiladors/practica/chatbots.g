#header
<<
#include <string>
#include <iostream>
#include <map>
#include <vector>
#include <cstdlib>
using namespace std;

// struct to store information about tokens
typedef struct {
  string kind;
  string text;
  int type;
} Attrib;

// function to fill token information (predeclaration)
void zzcr_attr(Attrib *attr, int type, char *text);

// fields for AST nodes
#define AST_FIELDS string kind; string text; int type;
#include "ast.h"

// macro to create a new AST node (and function predeclaration)
#define zzcr_ast(as,attr,ttype,textt) as=createASTnode(attr,ttype,textt)
AST* createASTnode(Attrib* attr, int ttype, char *textt);
>>

<<
#include <cstdlib>
#include <cmath>
// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {
    
    attr->kind = text;
    attr->text = "";
    attr->type = type;
    
}

// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
    AST* as   = new AST;
    as->kind  = attr->kind; 
    as->text  = attr->text;
    as->type  = attr->type;
    as->right = NULL; 
    as->down  = NULL;
    return as;
}

/// create a new "list" AST node with one element
AST* createASTlist(AST *child) {
    AST *as   = new AST;
    as->kind  = "list";
    as->right = NULL;
    as->down  = child;
    return as;
}

/// get nth child of a tree. Count starts at 0.
/// if no such child, returns NULL
AST* child(AST *a,int n) {
    AST *c=a->down;
    for (int i=0; c!=NULL && i<n; i++) 
        c=c->right;
    return c;
} 

/// print AST, recursively, with indentation
void ASTPrintIndent(AST *a,string s)
{
    if (a==NULL) return;
    
    cout<<a->kind;
    if (a->text!="") cout<<"("<<a->text<<")";
    cout<<endl;
    
    AST *i = a->down;
    while (i!=NULL && i->right!=NULL) {
        cout<<s+"  \\__";
        ASTPrintIndent(i,s+"  |"+string(i->kind.size()+i->text.size(),' '));
        i=i->right;
    }

    if (i!=NULL) {
        cout<<s+"  \\__";
        ASTPrintIndent(i,s+"   "+string(i->kind.size()+i->text.size(),' '));
        i=i->right;
    }
}

/// print AST 
void ASTPrint(AST *a)
{
    while (a!=NULL) {
        cout<<" ";
        ASTPrintIndent(a,"");
        a=a->right;
    }
}

// ---------------------
// ----- INTERPRET -----
// ---------------------

AST *root;
string nom_persona;
string valor;
string answ = "";
string ques = "";
map<string,string> qq;
map<string,vector<string> > aa;

void executeAnswer(AST *a) {
    if (a == NULL) return;
    
    if (answ != "") answ += " ";
    answ += a->kind;

    executeAnswer(a->right);
}

void executeEE(AST *a, string idn) {
    if (a != NULL) {
        if (a->type == NUM) {
            executeAnswer(child(child(a,0),0));
            aa[idn].push_back(answ);
            answ = "";
        }
        else {
            ques += a->kind + " ";
            if (a->right == NULL) {
                ques += "?";
                qq[idn] = ques;
                ques = "";
            }
        }
        executeEE(a->right,idn);
    }
}

void executeQA(AST *a) {
    if (a == NULL) return;
    if (child(a,0)->kind == "list") 
        executeEE(child(child(a,0),0), a->kind); 
    executeQA(a->right);
}

void executeConv2(AST *a) { 
    if (a != NULL) {
        cout << valor << " > " << nom_persona << ", " << qq[a->kind] << endl;
        int n = aa[a->right->kind].size();
        for (int i=0; i<n; ++i) {
            cout << i+1 << ": " << aa[a->right->kind][i] << endl;
        }
        cout << nom_persona << " > ";
        int a;
        cin \>> a;
    }
}

void executeConversation(AST *a, string cc) {
    if (a == NULL) return;
    if (a->kind == cc)
        executeConv2(child(child(a,0),0));
    executeConversation(a->right, cc);
}

void activaConversa(string cc) {
    executeConversation(child(child(root,0),0), cc);
}

void executeBoolean(AST *a) {
    if (a == NULL) return;
    if (a->kind == "THEN") {
        executeBoolean(child(a,0));
    }
    else if (a->kind == "OR"){
        int quantsOr = 0;
        for (int i=0; child(a,i) != NULL; ++i) {
            ++quantsOr;
        }
        activaConversa(child(a,rand()%quantsOr)->kind);
    }
    else {
        activaConversa(a->kind);
    }
    executeBoolean(a->right);
}

void executeList(AST *a) {
    if (a == NULL) return;
    string t = a->kind;
    executeBoolean(child(a,0));
}

void executeInteraccion(AST *a) {
    if (a == NULL) return;
    for (int i=0; child(a,i) != NULL; ++i) {
        int nom_text = child(a,i)->type;
                  valor = child(a,i)->kind;
        if (nom_text == NUM) {
            int seed = atoi(valor.c_str());
            srand(seed);
        }
        else {
            cout << endl << valor << " > WHAT IS YOUR NAME ? _\n";
            cin \>> nom_persona;
            executeList(child(child(root,1),i-1));
            cout << valor << " > THANKS FOR THE CHAT " << nom_persona << "\n";
        }
    }
}

int main() {
    root = NULL;
    ANTLR(chatbot(&root), stdin);
    ASTPrint(root);
    executeQA(child(child(root,0),0));
    executeInteraccion(child(root,2));
}

// -----------------------------
// ----- LEXIC I SINTACTIC -----
// -----------------------------

>>

#lexclass START
#token NUM "[0-9]+"
#token CMM "\,"
#token SCOLON "\;"
#token HASH "\#"
#token FLETXA "\-\>"
#token LEFT_P "\("
#token RIGHT_P "\)"
#token LEFT_C "\["
#token RIGHT_C "\]"
#token PT "\:"
#token INTRR "\?"
#token THEN "THEN"
#token OR "OR"
#token QUESTION "QUESTION"
#token ANSWERS "ANSWERS"
#token CONVERSAT "CONVERSATION"
#token CHATBOT "CHATBOT"
#token END "END"
#token INTERACTION "INTERACTION"
#token SPACE "[\ \n]" << zzskip();>>

#token ID "[a-zA-Z][a-zA-Z0-9]*"
#token IDENT "[a-zA-Z0-9]"


chatbot: conversations chats startchat <<#0 = createASTlist(_sibling);>> ;

conversations: (conversation)* <<#0 = createASTlist(_sibling);>> ;

conversation: ID^ PT! (question | answer | convers) ;

question: QUESTION! quest <<#0 = createASTlist(_sibling);>> ;
quest: (ID)+ INTRR! ;

answer: ANSWERS! ((answ1)* | answ2) <<#0 = createASTlist(_sibling);>> ;
answ1: NUM^ PT! answw ;
answw: (ID)* SCOLON! <<#0 = createASTlist(_sibling);>> ;

answ2: LEFT_C! listAns (ansCmm)* RIGHT_C! ;
ansCmm: CMM! listAns ;
listAns: LEFT_P! NUM^ CMM! listAns2 ;
listAns2: (ID)* RIGHT_P! <<#0 = createASTlist(_sibling);>> ;

convers: CONVERSAT! cconv ;
cconv: HASH! ID FLETXA^ HASH! ID ;

chats: (chatss)* <<#0 = createASTlist(_sibling);>> ;
chatss: CHATBOT! ID^ PT! boolean_expr;

boolean_expr: expr (OR^ expr (OR! expr)* | ) ;
expr: par (THEN^ par (THEN! par)* | ) ;
par: (LEFT_P! boolean_expr RIGHT_P! | HASH! ID) ;

startchat: INTERACTION! NUM (ID)* END! <<#0 = createASTlist(_sibling);>> ;