
/*  ===========================LOS SIMPSON ======================================*/



/* padres */
es_padre_de( homero,bart ).
es_padre_de( homero, lisa ).
es_padre_de( homero, maggie ).  

es_padre_de( abraham, homero).

es_padre_de( abraham, herbert).
es_padre_de( clancy , marge ).
es_padre_de( clancy , patty ).
es_padre_de( clancy , selma ).




/* madres */
es_madre_de( marge, bart).
es_madre_de( marge, lisa).
es_madre_de( marge, maggie ).
es_madre_de( mona, homero ).
es_madre_de( jacqueline , marge).
es_madre_de( jacqueline , selma).           
es_madre_de( jacqueline , patty).
es_madre_de(selma , ling).


/* hermanos */

es_hermano_de(X,Y) :- es_hombre(X),
    es_padre_de(Z,X),
    es_padre_de(Z,Y),
    X \= Y.

es_hermano_de(X,Y) :- es_hombre(X),
    es_madre_de(Z,X),
    es_madre_de(Z,Y),
    X \= Y.

/* hermanas */

es_hermana_de(X,Y) :- es_mujer(X),
    es_padre_de(Z,X),
    es_padre_de(Z,Y),
    X \= Y.



es_hermana_de(X,Y) :- es_mujer(X),
    es_madre_de(Z,X),
    es_madre_de(Z,Y),
    X \= Y.



/* mujeres */
es_mujer( marge ).
es_mujer( lisa ).
es_mujer( maggie ).
es_mujer( selma ).
es_mujer( patty ).
es_mujer( jacqueline ).
es_mujer( ling ).
es_mujer( mona ).


/* hombres */
es_hombre( bart ).
es_hombre( homero ).
es_hombre( herbert ).
es_hombre( abraham ).
es_hombre( clancy ).

/* esposos */
son_esposos(homero, marge).
son_esposos(marge, homero).




/* abuelos */
abuelo(X,Y) :- es_hombre(X),
    es_padre_de(X,Z),
    es_padre_de(Z,Y),
    X \= Y.

abuelo(X,Y) :- es_hombre(X),
    es_padre_de(X,Z),
    es_madre_de(Z,Y),
    X \= Y.


abuela(X,Y) :- es_mujer(X),
    es_madre_de(X,Z),
    es_padre_de(Z,Y),
    X \= Y.



abuela(X,Y) :- es_mujer(X),
    es_madre_de(X,Z),
    es_madre_de(Z,Y),
    X \= Y.




/* tios */

tio(X, Y) :- es_hombre(X),
    es_hermano_de(X,Z),
    es_padre_de(Z,Y),
    X \= Y.

tio(X,Y) :-
    es_hombre(X),
    es_hermano_de(X,Z),
    es_madre_de(Z,Y).


tia(X, Y) :- es_mujer(X),
    es_hermana_de(X,Z),
    es_padre_de(Z,Y),
    X \= Y.



tia(X, Y) :- es_mujer(X),
    es_hermana_de(X,Z),
    es_madre_de(Z,Y),
    X \= Y.



/* suegros */

suegro(X, Y) :- es_hombre(X),
    es_padre_de(X,Z),  
    son_esposos(Z,Y),
    X \= Y .         

suegra(X, Y) :- es_mujer(X),
    es_madre_de(X,Z),
    son_esposos(Z,Y),   
    X \= Y.


/* cuñados (en la consulta se escribe cunados para que no genere problemas la ñ en la funcion  ) */

cunado(X, Y) :- es_hombre(X),
    es_hermano_de(X,Z),
    son_esposos(Z,Y),
    X \= Y.

    
cunada(X, Y) :- es_mujer(X),
    es_hermana_de(X,Z),
    son_esposos(Z,Y),
    X \= Y.





/* sobrinos */

sobrino(X, Y) :- es_hombre(X),
    es_padre_de(Z,X),
    es_hermano_de(Z,Y),
    X \= Y.


sobrino(X, Y) :- es_hombre(X),
    es_madre_de(Z,X),
    es_hermana_de(Z,Y),
    X \= Y.


sobrina(X, Y) :- es_mujer(X),
    es_padre_de(Z,X),
    es_hermano_de(Z,Y),
    X \= Y.


sobrina(X, Y) :- es_mujer(X),
    es_madre_de(Z,X),
    es_hermana_de(Z,Y),
    X \= Y.




/* primos */
primo(X, W) :- es_hombre(X),
    es_hermano_de(Z,Y), 
    es_padre_de(Z,X),
    es_padre_de(Y,W),
    X \= W.


primo(X, W) :- es_hombre(X),
    es_hermana_de(Z,Y), 
    es_madre_de(Z,X),
    es_madre_de(Y,W),
    X \= W.



prima(X, W) :- es_mujer(X),
    es_hermana_de(Z,Y), 
    es_madre_de(Z,X),
    es_madre_de(Y,W),
    X \= W.


prima(X, W) :- es_mujer(X),
    es_hermano_de(Z,Y), 
    es_padre_de(Z,X),
    es_padre_de(Y,W),
    X \= W.






/* hijos */
hijo(X,Y) :- es_hombre(X),
    es_padre_de(Y,X),
    X \= Y.


hijo(X,Y) :- es_hombre(X),
    es_madre_de(Y,X),
    X \= Y.

hija(X,Y) :-  es_mujer(X), 
    es_padre_de(Y,X),
    X \= Y.


hija(X,Y) :-  es_mujer(X), 
    es_madre_de(Y,X),
    X \= Y .












