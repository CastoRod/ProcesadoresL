parser grammar Anasint;
options{
 tokenVocab=Analex;
}
programa: PROGRAMA variables subprogramas instrucciones EOF;

//VARIABLES
variables : VARIABLES lista_variables*;
lista_variables : IDENT COMA lista_variables
    | IDENT DP tipo PyC
    ;

tipo : SEQ (PA NUM PC|PA LOG PC)*
    |NUM
    |LOG
    ;

//SUBPROGRAMAS
declaracion: variables instrucciones;

subprogramas : SUBPROGRAMAS (funciones)* (procedimientos)*;

funciones:   predicado
           | FUNCION IDENT(PA tipo IDENT(COMA tipo IDENT)* PC)? DEV (PA tipo IDENT(COMA tipo IDENT)* PC)
             declaracion
             FFUNCION
           | IDENT(PA expresion PC)?
           | ULTIMAPOSICION(PA secuencia PC);

predicado: FUNCION IDENT(PA tipo IDENT(COMA tipo IDENT)* PC)? DEV (PA LOG IDENT) PC
           declaracion
           FFUNCION
           | VACIA(PA secuencia PC)
           ;

procedimientos: PROCEDIMIENTO IDENT(PA tipo IDENT(COMA tipo IDENT)* PC)
                declaracion
                FPROCEDIMIENTO
                | IDENT(PA expresion PC)?
                | mostrar
                ;

//INSTRUCCIONES
instrucciones: INSTRUCCIONES instruccion*;
instruccion: ruptura
           | iteracion
           | asignacion
           | condicional
           | devolucion
           | llamada_funcion
           | llamada_procedimiento
           | mostrar
           ;

// Instrucciones: asignación
asignacion : IDENT (COMA IDENT)* IGUAL expresion (COMA expresion)* PyC;

expresion : expresion_no_elemental | expresion_entera | expresion_logica ;

funcion_entera: POR
    | MAS
    | MENOS
    ;

expresion_entera : PA expresion_entera PC
    | expresion_entera (funcion_entera expresion_entera)+
    | NUMERO
    | IDENT
    | llamada_funcion
    ;

expresion_logica : TRUE
    | FALSE
    ;

expresion_no_elemental : CA secuencia CC
    | CA CC
    ;

secuencia: expresion_entera (COMA expresion_entera)*
    |expresion_logica (COMA expresion_logica)*
    ;

// Instrucciones: iteracion
iteracion:  MIENTRAS PA condicion PC HACER
    | BA iteracion* BC
    | FMIENTRAS
    ;

// Instrucciones: condicional
condicional: SI PA condicion PC ENTONCES
                instruccion*
             SINO?
                instruccion*
             FINSI
           ;
condicion: NEGACION condicion
         | condicion Y condicion
         | condicion O condicion
         | expresion relacion_binaria expresion
         | CIERTO
         | FALSO
         ;

relacion_binaria: MAYORIGUAL|MENORIGUAL|MAYOR|MENOR|IGUALDAD|DISTINTO;

//Instrucciones: devolución
devolucion: DEV (IDENT)(COMA IDENT)* PyC
            | DEV (TRUE|FALSE) PyC;

//Instrucciones: llamadas
llamada_funcion: funciones;

llamada_procedimiento: procedimientos;

//Instrucciones: ruptura
ruptura: RUPTURA PyC;

//Instrucciones: mostrar
mostrar: MOSTRAR PA IDENT PC PyC;