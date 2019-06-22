program Ejercicio;

var
	tanque 			: MonitorTanque;

procedure generadora(maquina : integer)
	begin
		while (true) do
		begin
			maquina.generarBebida();
			tanque.comienzoColocarBebida();
			maquina.descargarEnTanque();
			tanque.finColocarBebida();
		end;
	end;

procedure embotelladora(embotelladora : integer)
	begin
		while (true) do
		begin
			tanque.comienzoLlenarLata();
			embotelladora.taparEtiquetarLata();
			tanque.finLlenarLata();
			embotelladora.llenarLata();
		end;
	end;

procedure inspector()
	begin
		while (true) do
		begin
			tanque.comienzoInsepccionar();
			tomarMuestra();
			procesarSolucinoar();
			tanque.finInsepccionar();
			otrasTareas();
		end;
	end;

begin
	cobegin
		embotelladora();
		embotelladora();
		embotelladora();
		embotelladora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		generadora();
		inspector();
	coend;
end;