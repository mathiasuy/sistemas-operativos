Monitor Marmita
VAR
	//Lo usaré para controlar que no haya más de 6 comensales como pide la letra
	cant_canibales  : integer; 
	relleno			: boolean;
	cnd_rellenar, cnd_canibal, cnd_cocinero : Conditional;

	{ Los canibales indican que quieren comer }
	PROCEDURE quiero_comer()
	BEGIN
		if ((cant_comenzales >= 6) or relleno) then
			//Si no se cumplen las condiciones, porque hay 6 comiendo o 
			//más o hay que rellenar la marmita, espero
			cnd_canibal.wait();
		end;
		if (not hay_suficiente_comida()) then
			//Si no hay  suficiente comida, indico que hay que rellenar la marmita
			relleno := true;
			if (cant_canibales = 0) then
				//Si además  no hay canibales, hay que llamar al cocinero para que la rellene
				cnd_cocinero.signal();
			end;
			//Espero a que el cocinero termine de rellenar
			cnd_rellenar.wait();
			//Una vez que terminó de rellenar, comienzan a comer
		end;
		cant_canibales++;
		if (not relleno and cant_canibales < 6) then
			//Si  no hay que rellenar y hay menos de 6
			// canibales puedo despertar a otro canibal para que se sume a la movida
			// esta de comer de la marmita
 			cnd_canibal.signal();
		end;
	END puedo_comer:

	{ El canibal indica que terminó de comer }
	PROCEDURE termine_comer()
	BEGIN
		//Canibal abandona la marmita, decremento cantidad de canibales
		cant_canibales--;
		if ((cant_canibales=0) and relleno) then
			//Si no quedaron canibales en la marmita y hay que rellenar
			//Llamo al cocinero
			cnd_cocinero.signal();
		end;
		if (not relleno) then
			//Si no hay que rellenar, hayan o no canibales, 
			//llamo al siguiente canibal (ya que se supone que se libera un lugar)
			cnd_canibal.signal();
		end;
	END termine_comer;

	{ El cocinero indica que quiere cocinar. Si no puede, se quedará bloqueado aquí }
	PROCEDURE quiero_cocinar()
	BEGIN
		if ((cant_canibales <> 0) or not relleno) then
			//Si hay canibales en la marmita o no hay que rellenar la marmita
			cnd_cocinero.wait();
		end;
	END quiero_cocinar;
		
	{ El cocinero avisa que termina de cocinar y llama a los canibales que se quedaron 	}
	{ esperando a que el relleno esté listo 											}
	PROCEDURE termine_cocinar()
	BEGIN
		relleno := false;
		//Despierto al primer canibal que avisó que falta relleno
		cnd_rellenar.signal();
	END quiero_cocinar;

BEGIN
	relleno := False;
	cant_canibales := 0;
END Marmita;