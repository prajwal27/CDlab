
/*** Definition Section has one variable 
which can be accessed inside yylex()  
and main() 
***/
%{ 
int count = 0; 
int lineCount = 1;
%} 
  

%% 
\/\*(.*\n)*(.*)\*\/ {printf("multiline");} 
[ \t] {fprintf(yyout, "");} 
.     { if(lineCount == 1) {
            fprintf(yyout, "1. %s", yytext);
            lineCount++;count++;
        }else if(count == 0) {
            fprintf(yyout,"%d. %s",lineCount,yytext);
            count++;
        }else{
            fprintf(yyout, "%s", yytext);count++;
        }
      } 
\n    { if(lineCount == 1)
        {
            fprintf(yyout, "%d. \n", lineCount); lineCount++;
        }else{
            fprintf(yyout, "\n%d. ", lineCount); lineCount++;
        }
    } 
%% 
  

int yywrap(){} 
int main(){ 
  
// Explanation: 
// yywrap() - wraps the above rule section 
/* yyin - takes the file pointer  
          which contains the input*/
/* yylex() - this is the main flex function 
          which runs the Rule Section*/
// yytext is the text in the buffer 
  

 FILE *fp; 
 char filename[50]; 
 printf("Enter the filename: \n"); 
 scanf("%s",filename); 
 fp = fopen(filename,"r"); 
 yyin = fp; 
 yyout=fopen("oLab1.c","w");
  
yylex(); 
printf("\nNumber of Captial letters " 
      "in the given input - %d\n", count); 
  
return 0; 
} 
