parser grammar Anasint;
options{
    tokenVocab=Analex;
}

programa: PROGRAMA variables subprogramas instrucciones EOF;

subprogramas : SUBPROGRAMAS;

variables: VARIABLES (decl_vars)*;

    decl_vars: vars DP tipo PYC;

        vars: IDENT (COMA vars)*;

        tipo: elemental | no_elemental;

            elemental: NUM | LOG;

            no_elemental: SEQ_NUM | SEQ_LOG;


instrucciones: INSTRUCCIONES (instruccion)*;

    instruccion: (asignacion | llamada | devuelve | muestra | ruptura) PYC
               | (condicional | iteracion )
               ;

    asignacion: (asig_simple | asig_multiple)+;

        asig_simple: IDENT (CA IDENT CC)* ASIG  expr;

        expr: PA expr PC                #ParExpr
            | expr POR expr             #PorExpr
            | expr (MAS | MENOS) expr   #MasMenosExpr
            | llamada                   #LlamadaExpr
            | secuencia                 #SecuenciaExpr
            | acceso                    #AccesoExpr
            | valor_logico              #ValorLogicoExpr
            | IDENT                     #IdentExpr
            | NUMERO                    #NumExpr
            ;

            valor_logico: CIERTO | FALSO | T | F;

            llamada: IDENT PA (terms)? PC;

            secuencia: CA (terms)? CC;

            devuelve: DEV terms;

            terms: expr COMA terms | expr;

            acceso: IDENT CA expr CC;

        asig_multiple: IDENT (CA IDENT CC)* (COMA IDENT)+ ASIG terms ;



    condicional: SI PA condicion PC ENTONCES bloque (SINO bloque)? FSI;

        bloque: (instruccion)+;

        condicion: NO condicion                    #NOCond
                 | condicion (Y|O) condicion       #YOCond
                 | PA condicion PC                 #ParCond
                 | condicion op_log condicion      #OpCond
                 | expr                            #ExprCond
                 ;

        op_log: IGUAL | DISTINTO | MAYOR | MENOR | MAYOR_IGUAL | MENOR_IGUAL | CIERTO;

    iteracion: MIENTRAS PA condicion PC HACER bloque FMIENTRAS;

    muestra: MOSTRAR PA IDENT (COMA IDENT)* PC;

    ruptura: RUPTURA;

