Monitor Tablero:
	VAR
		cant_jugando, cant_sacar_carta : integer;
		jefe_esperando : boolean;
		jefe, jugador 	: Conditional;
		
	{ El jefe puede reordenar el tablero cuando no hay jugadores en el 	}
	{ Caso contrario, se queda esperando a que se libere el tablero.	}
	PROCEDURE reordenar() 
	BEGIN
		jefe_esperando := true;
		if (cant_jugando > 0) then 
			jefe.wait();
		end;
		reordenar_tablero();
		jefe_esperando := false;
		jugador.signal();
	END

	{ Si un jugador quiere jugar, primero me fijo si hay un jefe esperando para reordenar 		}
	{ si lo hay, el jugador puede sacar una carte, caso contrario no saca carta y juega	directo	}
	PROCEDURE entra_jugador(sacar_carta out Carta)
	BEGIN
		if (jefe_esperando) then
			sacar_carta := true;
			cant_sacar_carta++;
		else
			cant_jugando++;
			sacar_carta := false;
		end
	END

	{ El jugador presenta su carta al tablero, si la carta dice ESPERAR, se queda bloqueado	hasta	}
	{ que el jefe lo despierte después de reordenar (aún no lo hará si hay  jugadores en el tablero	}
	{ o hay jugadores en cola para sacar carta). Si la carta dice JUGAR, juega directo				}
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
	END

	{ El jugador sale del tablero. Para eso se baja el contador de jugadores en 1 	}
	{ y si el contador de jugadores es 0 y ademas no hay jugadores para sacar carta }
	{ se invoca a que continúe el jefe 												}
	PROCEDURE sale_jugador()
	BEGIN
		cant_jugando--;
		if ((cant_jugando = 0) and (cant_sacar_carta = 0)) then
			jefe.signal();
		end
	END

BEGIN
	cant_jugando = 0;
	cant_sacar_carta = 0;
	jefe_esperando = false;
END Tablero;


