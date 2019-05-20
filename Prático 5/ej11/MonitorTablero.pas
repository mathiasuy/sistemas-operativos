Monitor Tablero:
	VAR
		cant_jugando, cant_sacar_carta : integer;
		jefe_esperando : boolean;
		jefe, jugador 	: Conditional;
		

	PROCEDURE reordenar() 
	BEGIN
		jefe_esperando := true;
		if (cant_jugando > 0) then 
			jefe.wait();
		end;
		reordenar_tablero();
		jefe_esperando := false;
		jugador.signal();
	END;

	PROCEDURE entra_jugador(sacar_carta out Carta)
	BEGIN
		if (jefe_esperando) then
			sacar_carta := true;
			cant_sacar_carta++;
		else
			cant_jugando++;
			sacar_carta := false;
		end;
	END;

	PROCEDURE mostrar_carta(carta in Carta)
	BEGIN
		cant_sacar_carta--;
		if (carta == ESPERAR) then
			if ((cant_jugando = 0) and (cant_sacar_carta = 0)) then
				//como no hay jugadores, el jefe puede reordenar
				jefe.signal();
			end;
			//jugador tiene que esperar por la carta que le tocó anteriormente ESPERAR
			jugador.wait(); 
			jugador.signal(); //le doy paso al siguiente despues de que me despierten
		end;
		cant_jugando++;
	END;

	PROCEDURE sale_jugador()
	BEGIN
		cant_jugando--;
		if ((cant_jugando = 0) and (cant_sacar_carta = 0)) then
			jefe.signal();
		end;

BEGIN
	cant_jugando = 0;
	cant_sacar_carta = 0;
	jefe_esperando = false;
END Tablero;


