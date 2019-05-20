Monitor Marmita
VAR
	//Lo usaré para controlar que no haya más de 6 comensales como pide la letra
	cant_canibales  : integer; 
	relleno			: boolean;
	cnd_relleno, cnd_canibal, cnd_cocinero : Conditional;

	PROCEDURE quiero_comer()
	BEGIN
		if ((cant_comenzales >= 6) or relleno) then
			cnd_canibal.wait();
		end;
		if (not hay_suficiente_comida()) then
			relleno := true;
			if (cant_canibales = 0) then
				cnd_cocinero.signal();
			end;
			cnd_relleno.wait();
		end;
		cant_canibales++;
		if (not relleno and cant_canibales < 6) then
			cnd_canibal.signal();
		end;
	END puedo_comer:

	PROCEDURE termine_comer()
	BEGIN
		cant_canibales--;
		if ((cant_canibales=0) and rellenar) then
			cnd_cocinero.signal();
		end;
		if (not rellenar) then
			cnd_canibal.signal();
		end;
	END termine_comer;

	PROCEDURE quiero_cocinar()
	BEGIN
		if ((cant_canibales <> 0) or not rellenar) then
			cnd_cocinero.wait();
		end;
	END quiero_cocinar;
		

	PROCEDURE termine_cocinar()
	BEGIN
		relleno := false;
		cnd_relleno.signal();
	END quiero_cocinar;

BEGIN
	rellenar := False;
	cant_canibales := 0;
END Marmita;
		




	END comer;

END Marmita;