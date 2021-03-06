lexer grammar Analex;
BLANCO: ' ' ->skip;
TABULADOR: '\t'->skip;
FIN_LINEA: '\r'?'\n' ->skip;
fragment DIGITO: [0-9];
fragment LETRA:[a-zA-Z];
PROGRAMA : 'PROGRAMA';
NUM: 'NUM';
VARIABLES: 'VARIABLES';
ASIGNACIONES : 'ASIGNACIONES';
ITERACIONES: 'ITERACIONES';
INSTRUCCIONES: 'INSTRUCCIONES';
SUBPROGRAMAS: 'SUBPROGRAMAS';
PROCEDIMIENTO: 'PROCEDIMIENTO';
FPROCEDIMIENTO: 'FPROCEDIMIENTO';
FUNCION: 'FUNCION';
FFUNCION: 'FFUNCION';
RUPTURA: 'ruptura';
MOSTRAR: 'mostrar';
ULTIMAPOSICION: 'ultima_posicion';
VACIA: 'vacia';
DEV: 'dev';
LOG: 'LOG';
SEQ: 'SEQ';
MIENTRAS: 'mientras';
HACER: 'hacer';
FMIENTRAS: 'fmientras';
SI : 'si';
SINO : 'sino';
ENTONCES : 'entonces';
CIERTO : 'cierto';
FALSO : 'falso';
FINSI : 'fsi';
TRUE : 'T';
FALSE : 'F';
POR: '*';
MAS: '+';
MENOS: '-';
NUMERO : ('-')?DIGITO+;
IDENT : LETRA(LETRA|DIGITO|'_')*;
MAYOR : '>' ;
MENOR : '<' ;
PA : '(';
PC : ')';
BA: '{';
BC: '}';
PyC : ';';
COMA : ',';
DP : ':';
IGUAL : '=';
CA : '[' ;
CC : ']' ;
NEGACION : '!';
Y : '&&';
O : '||';
IGUALDAD : '==';
MAYORIGUAL : '>=';
MENORIGUAL : '<=';
DISTINTO : '!=';
COMENTARIO_BLOQUE : '/*' .*? '*/' -> skip ;
COMENTARIO_LINEA : '//' .*? FIN_LINEA -> skip ;