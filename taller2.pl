

/* ====================== solucion a las preguntas =================================*/ 

/* conexiones */

viajar(vancouver, edmonton, 16).
viajar(vancouver, calgary, 13).
viajar(edmonton, saskatoon, 12).
viajar(saskatoon , winnipeg, 20).
viajar(saskatoon , calgary, 9).
viajar(calgary, regina, 14).
viajar(regina , winnipeg,  4).
viajar(calgary, edmonton, 4).




costo_de_viaje(Origen, Destino) :- 
    viajar(Origen, Destino, Precio), 
    write('El precio del viaje de '), 
    write(Origen), 
    write(' a '), 
    write(Destino), 
    write(' es: '), 
    write(Precio).


tiene_arista_un_nodo(X,Y) :- 
    	viajar(X,Y,_),
    	write(' si tiene arista el nodo '),
    	write( X ),
		write(' y es  '),
		write(Y).



conexion(X,Y) :-
    viajar(X,Y,_).

conexion(X,Y) :-
    viajar(X,Z,_),
    viajar(Z,Y,_).


conectado_con(X,Y,Precio) :-
    viajar(X,Y,Precio).

costo_pasando_por(X,Y,Z,CostoTotal) :-
    viajar(X,Y,Costo1),
    viajar(Y,Z,Costo2),
    CostoTotal is Costo1 + Costo2.
    
    
viaje_por_escalas(X,Y) :- viajar(X, Y,_).
viaje_por_escalas(X,Y) :- viajar(X, Z,_), viajar(Z, Y,_). 
viaje_por_escalas(X,Y) :- viajar(X, Z1,_), viajar(Z1, Z2,_), viajar(Z2, Y,_).
    
    
    
    
    
    
