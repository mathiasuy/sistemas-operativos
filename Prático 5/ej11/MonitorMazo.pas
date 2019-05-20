Monitor Mazo:
	VAR
		cant_cartas : integer;


	PROCEDURE sacar_carta(carta out Carta) : Carta
	BEGIN
		if (cant_cartas == 0) then
			carta := ESPERAR;
		else
			carta := sacar_carta_De_mazo();
			cant_cartas--;
			colocar.signal();
		end;
	END;

	PROCEDURE colocar_carta(carta in Carta)
	BEGIN
		if (cant_cartas == 10) then
			colocar.wait();
		end;
		colocar_carta_en_mazo(carta);
		cant_cartas++;

	END;

END Mazo;

