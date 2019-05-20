{ Proceso correspondiente al canibal }
PROCEDURE canibal()
BEGIN
	while (true) do
		//Aviso a la marmita que voy a comer
		//Si no puedo, quedo bloqueado a la espera
		marmita.puedo_comer();
		//Continúa el flujo y ahora puedo comer
		comer();
		//Aviso a la marmita que terminé de comer
		marmita.termine_comer();
		//Continúo con otro ejercicio de Sistemas Operativos.
		ocio();
	end;
END canibal;

{ Proceso correspondiente al cocinero }
PROCEDURE cocinero()
BEGIN
	while (true) do
		//El cocinero avisa a la marmita que quiere cocinar
		//Si no es el momento, quedará bloquead, a la espera, en el método
		marmita.quiero_cocinar();
		//Se desbloqueó, por lo que continúa el flujo y empieza a cocinar
		cocinar();
		//Avisa a la marmita que terminó
		marmita.termine_cocinar();
		//Nos vemo...
		ocio();
	end;
END canibal;