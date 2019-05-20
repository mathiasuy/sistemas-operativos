Monitor Mazo:
	VAR
		cant_cartas : integer;


	PROCEDURE sacar_carta(carta out Carta) : Carta
	BEGIN
		if (cant_cartas == 0) then
			//Si no hay cartas en el mazo, doy la carta por defecto de ESPERAR;
			carta := ESPERAR;
		else
			carta := sacar_carta_De_mazo();
			cant_cartas--;
			//Como seguro hay menos de 10 cartas, permito que el jefe pueda agregar más cartas
			colocar.signal();
		end;
	END;

	{ Solo el jefe podrá colocar cartas en el mazo y este será el único en 		} 
	{ acceder a el cuando lo haga. No podrá haber más de 10 cartas en el mazo 	}
	PROCEDURE colocar_carta(carta in Carta)
	BEGIN
		if (cant_cartas == 10) then
			//Si hay 10 cartas en el mazo, el jefe para colocar una 
			//carta deberá esperar a que alguien quite una carta del mazo
			colocar.wait();
		end;
		colocar_carta_en_mazo(carta);
		cant_cartas++;
	END;

END Mazo;

