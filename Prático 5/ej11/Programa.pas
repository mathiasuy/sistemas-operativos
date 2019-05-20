PROCEDURE jefe_tablero()
BEGIN
	while (true) do
		pensar_reordenamiento();
		tablero.reordenar();
	end;
END;

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
