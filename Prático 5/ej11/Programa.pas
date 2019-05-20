{ El jefe estará constantemente pensando y reordenando el tablero }
PROCEDURE jefe_tablero()
BEGIN
	while (true) do
		pensar_reordenamiento();
		//Reordeno el tablero, el monitor se encargará del control
		//de que sea el único en el tablero. Mientras ejecute este
		//método nadie puede usar el monitor y tampoco podré ejecutarlo
		//Si hay jugadores registrados en el monitor
		tablero.reordenar();
	end;
END;

{ El jefe también estará constanemente eligiendo cartas y colocando en el mazo }
PROCEDURE jefe_mazo()
	var
		Carta : {JUGAR, ESPERAR};
BEGIN
	while (true) do
		carta := elegir_proxima_carta();
		mazo.colocar_carta(carta);
	end;
END jefe_mazo;

{ El jugador estará constantemente pensando jugada, entrando al tablero, 	}	
{ el cuál le indicará si debe sacar una carta, en tal caso, toma una carta 	}
{ y en base a eso espera o juega, luego sale de tablero 					}
PROCEDURE jugador()
	var 
		sacar_carta : boolean;
BEGIN
	while (true) do
		pensar_jugada();
		//El monitor me  dirá si debo sacar una carta o jugar directo
		tablero.entra_jugador(sacar_carta);
		if (sacar_carta) then
			//El monitor me dirá si debo esperar o no
			mazo.sacar_carta(carta);
			//En base a lo anterior, espero a que el jefe reordene o juego directo
			tablero.mostrar_carta(carta);
		end;
		//juego
		jugar();
		//indico al monitor tablero que salgo del tablero
		tablero.sale_jugador();
	end;
END;
