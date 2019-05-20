PROCEDURE canibal()
BEGIN
	while (true) do
		marmita.puedo_comer();
		comer();
		marmita.termine_comer();
		ocio();
	end;
END canibal;

PROCEDURE cocinero()
BEGIN
	while (true) do
		marmita.quiero_cocinar();
		cocinar();
		marmita.termine_cocinar();
		ocio();
	end;
END canibal;