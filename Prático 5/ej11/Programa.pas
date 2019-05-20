{ El jefe estará constantemente pensando y reordenando el tablero }
PROCEDURE jefe_tablero()
BEGIN
	while (true) do
		pensar_reordenamiento();
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
		tablero.entra_jugador(sacar_carta);
		if (sacar_carta) then
			mazo.sacar_carta(carta);
			tablero.mostrar_carta(carta);
		end;
		jugar();
		tablero.sale_jugador();
	end;
END;
