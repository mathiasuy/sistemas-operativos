program ConSemaforos;

var
	cantMaxima			: Semaphore;
	bebidasListas 		: Semaphore;
	mtxGenerar			: Semaphore;
	mtxBloquearTanque	: Semaphore;
	mtxLlenarLata		: Semaphore;

procedure generadora()
	begin
		while (true) do
		begin
			P(cantMaxima); //Dejo avanzar si faltan bebidas, en caso de semaforo = 0 no faltarían bebidas y trancaría aquí
			generarBebida();
			P(mtxGenerar); // Mutex para que no se generen varias a la vez
			P(mtxBloquearTanque);//Mutex para apoderarse de tanque
			descargarEnTanque();
			V(mtxBloquearTanque);
			V(mtxGenerar);
			V(bebidasListas);
		end;
	end;

procedure embotelladora()
	begin
		while (true) do
		begin
			P(mtxLlenarLata);
			P(mtxBloquearTanque);//Mutex para apoderarse de tanque
			llenarLata();
			V(mtxBloquearTanque);//Mutex para apoderarse de tanque
			V(mtxLlenarLata);
			V(cantMaxima); //Aumento en uno para indicar que se puede generar uno más
			taparEtiquetarBotella();
			P(bebidasListas);
		end;
	end;

procedure inspector()
	begin
		while (true) do
		begin
			P(bebidasListas);//Si no hay bebidas, que no avance
			P(mtxBloquearTanque);//Mutex para apoderarse de tanque
			tomarMuesta();
			procesarSolucionar();
			V(bebidasListas);//Reestablezco este indicador ya que la letra indica que la cantidad que usa el inspector es despreciable
			V(mtxBloquearTanque);//Mutex para apoderarse de tanque
			otrasTareas();
		end;
	end;

begin
	init(cantMaxima,10);
	init(bebidasListas,0);
	init(mtxGenerar,1);
	init(mtxBloquearTanque,1);
	init(mtxLlenarLata,1);

	cobegin
		generadora();
		embotelladora();
		inspector();
	coend

END;

