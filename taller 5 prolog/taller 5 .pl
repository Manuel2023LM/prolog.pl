/* ======================
   CIUDADES DE CANADÁ
 
====================== */


/* Base de datos  */
conexiones([
    conexion(ciudad(vancouver), ciudad(edmonton), costo(16)),
    conexion(ciudad(vancouver), ciudad(calgary), costo(13)),
    conexion(ciudad(edmonton), ciudad(saskatoon), costo(12)),
    conexion(ciudad(saskatoon), ciudad(winnipeg), costo(20)),
    conexion(ciudad(saskatoon), ciudad(calgary), costo(9)),
    conexion(ciudad(calgary), ciudad(regina), costo(14)),
    conexion(ciudad(regina), ciudad(winnipeg), costo(4)),
    conexion(ciudad(calgary), ciudad(edmonton), costo(4))
]).


/* ======================
   REGLA BASE
====================== */


viajar(O,D,C) :-
    conexiones(L),
    member(conexion(ciudad(O), ciudad(D), costo(C)), L).


/* ======================
   CONSULTAS ORIGINALES
====================== */


/* Costo de viaje */
costo_de_viaje(O,D) :-
    viajar(O,D,C),
    write('El precio del viaje de '),
    write(O),
    write(' a '),
    write(D),
    write(' es: '),
    write(C).


/* Tiene arista */
tiene_arista_un_nodo(O,D) :-
    viajar(O,D,_),
    write('si tiene arista el nodo '),
    write(O),
    write(' y es '),
    write(D).


/* Conexión directa */
conexion(O,D) :-
    viajar(O,D,_).


/* Conexión con una escala */
conexion(O,D) :-
    viajar(O,Z,_),
    viajar(Z,D,_).


/* Conexión recursiva */
conexion(O,D) :-
    ruta(O,D,_,_).




/* Conectado con costo */
conectado_con(O,D,C) :-
    viajar(O,D,C).


/* Costo pasando por una ciudad */
costo_pasando_por(O,Y,D,CostoTotal) :-
    viajar(O,Y,C1),
    viajar(Y,D,C2),
    CostoTotal is C1 + C2.


/* Viaje por escalas  */
viaje_por_escalas(O,D) :- viajar(O,D,_).


viaje_por_escalas(O,D) :-
    viajar(O,Z,_),
    viajar(Z,D,_).


viaje_por_escalas(O,D) :-
    viajar(O,Z1,_),
    viajar(Z1,Z2,_),
    viajar(Z2,D,_).


viaje_por_escalas(O,D,Ruta) :-
    ruta(O,D,Ruta,_),
    Ruta \= [D].


/* ======================
   MEJORAS recursividad
====================== */


/* Camino general sin repetir ciudades */
camino(O,D,Visitados,[D],Costo) :-
    viajar(O,D,C),
    \+ member(D,Visitados),
    Costo is C.


camino(O,D,Visitados,[Z|Ruta],CostoTotal) :-
    viajar(O,Z,C1),
    Z \= D,
    \+ member(Z,Visitados),
    camino(Z,D,[Z|Visitados],Ruta,C2),
    CostoTotal is C1 + C2.


/* Ruta completa de una ciudad a otra */
ruta(O,D,Ruta,Costo) :-
    camino(O,D,[O],Ruta,Costo).


/* ======================
   PRUEBAS
======================


?- viajar(vancouver, calgary, C).
?- costo_de_viaje(vancouver, calgary).
?- conexion(vancouver, winnipeg).
?- conectado_con(calgary, edmonton, C).
?- costo_pasando_por(vancouver, calgary, regina, C).
?- viaje_por_escalas(vancouver, winnipeg).




?- ruta(vancouver, winnipeg, Ruta, Costo).


*/








/* ===========================
   LOS SIMPSON
   
=========================== */


/* ======================
   BASE DE DATOS (LISTAS)
====================== */


familia([
    padre(homero, bart),
    padre(homero, lisa),
    padre(homero, maggie),
    padre(abraham, homero),
    padre(abraham, herbert),
    padre(clancy, marge),
    padre(clancy, patty),
    padre(clancy, selma),


    madre(marge, bart),
    madre(marge, lisa),
    madre(marge, maggie),
    madre(mona, homero),
    madre(jacqueline, marge),
    madre(jacqueline, selma),
    madre(jacqueline, patty),
    madre(selma, ling)
]).


personas([
    hombre(bart), hombre(homero), hombre(herbert),
    hombre(abraham), hombre(clancy),


    mujer(marge), mujer(lisa), mujer(maggie),
    mujer(selma), mujer(patty),
    mujer(jacqueline), mujer(ling), mujer(mona)
]).


relaciones([
    pareja(homero, marge),
    pareja(marge, homero)
]).


/* ======================
   REGLAS BASE
====================== */


es_padre_de(X,Y) :-
    familia(L),
    member(padre(X,Y), L).


es_madre_de(X,Y) :-
    familia(L),
    member(madre(X,Y), L).


/* Unificación padre/madre */
progenitor(X,Y) :- es_padre_de(X,Y).
progenitor(X,Y) :- es_madre_de(X,Y).


es_hombre(X) :-
    personas(L),
    member(hombre(X), L).


es_mujer(X) :-
    personas(L),
    member(mujer(X), L).


son_esposos(X,Y) :-
    relaciones(L),
    member(pareja(X,Y), L).


/* ======================
   RELACIONES ORIGINALES
====================== */


/* Hermanos */
es_hermano_de(X,Y) :-
    es_hombre(X),
    progenitor(Z,X),
    progenitor(Z,Y),
    X \= Y.


es_hermana_de(X,Y) :-
    es_mujer(X),
    progenitor(Z,X),
    progenitor(Z,Y),
    X \= Y.


/* Abuelos */
abuelo(X,Y) :-
    es_hombre(X),
    progenitor(X,Z),
    progenitor(Z,Y),
    X \= Y.


abuela(X,Y) :-
    es_mujer(X),
    progenitor(X,Z),
    progenitor(Z,Y),
    X \= Y.


/* Tíos */
tio(X,Y) :-
    es_hombre(X),
    es_hermano_de(X,Z),
    progenitor(Z,Y),
    X \= Y.


tia(X,Y) :-
    es_mujer(X),
    es_hermana_de(X,Z),
    progenitor(Z,Y),
    X \= Y.


/* Suegros */
suegro(X,Y) :-
    es_hombre(X),
    progenitor(X,Z),
    son_esposos(Z,Y),
    X \= Y.


suegra(X,Y) :-
    es_mujer(X),
    progenitor(X,Z),
    son_esposos(Z,Y),
    X \= Y.


/* Cuñados */
cunado(X,Y) :-
    es_hombre(X),
    es_hermano_de(X,Z),
    son_esposos(Z,Y),
    X \= Y.


cunada(X,Y) :-
    es_mujer(X),
    es_hermana_de(X,Z),
    son_esposos(Z,Y),
    X \= Y.


/* Sobrinos */
sobrino(X,Y) :-
    es_hombre(X),
    progenitor(Z,X),
    es_hermano_de(Z,Y),
    X \= Y.


sobrina(X,Y) :-
    es_mujer(X),
    progenitor(Z,X),
    es_hermana_de(Z,Y),
    X \= Y.


/* Primos */
primo(X,W) :-
    es_hombre(X),
    progenitor(Z,X),
    progenitor(Y,W),
    es_hermano_de(Z,Y),
    X \= W.


prima(X,W) :-
    es_mujer(X),
    progenitor(Z,X),
    progenitor(Y,W),
    es_hermana_de(Z,Y),
    X \= W.


/* Hijos */
hijo(X,Y) :-
    es_hombre(X),
    progenitor(Y,X),
    X \= Y.


hija(X,Y) :-
    es_mujer(X),
    progenitor(Y,X),
    X \= Y.


/* ======================
   MEJORAS 
====================== */


/* Ancestros (recursivo) */
ancestro(X,Y) :-
    progenitor(X,Y).


ancestro(X,Y) :-
    progenitor(X,Z),
    ancestro(Z,Y).


/* Lista de hijos */
hijos_de(X,Lista) :-
    findall(Y, progenitor(X,Y), Lista).


/* ======================
   PRUEBAS
======================


?- es_padre_de(homero, bart).
?- es_madre_de(marge, lisa).
?- es_hermano_de(bart, lisa).
?- abuelo(abraham, bart).
?- tio(herbert, bart).
?- suegro(clancy, homero).
?- cunado(herbert, marge).
?- sobrino(bart, selma).
?- primo(bart, ling).




?- ancestro(abraham, maggie).
?- hijos_de(homero, L).


*/

