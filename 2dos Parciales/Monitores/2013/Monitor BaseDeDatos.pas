Monitor Lote

	var
		cantFuncionariosEsperandoParaModificar : integer;
		cantFuncionariosAdentro : integer;
		cantFuncionarios : integer;

procedure entrarAModificarFuncionario()
	begin
		if (estaSupervisor) then
			cantFuncionariosEsperandoParaModificar := cantFuncionariosEsperandoParaModificar + 1;
			modificar.wait();
			cantFuncionariosEsperandoParaModificar := cantFuncionariosEsperandoParaModificar - 1;
		end;
		cantFuncionariosAdentro := cantFuncionariosAdentro + 1;
	end;

procedure saleDeModificarFuncionario()
	begin
		cantFuncionariosAdentro := cantFuncionariosAdentro - 1;
		if (supervisorQuiereEntrar) then
			supervisor.signal();
		else if (cantFuncionariosEsperandoParaModificar > 0) then
			modificar.signal();
		else
			leer.signal();
		end;
	end;

procedure entrarALeerFuncionario()
	begin
		if (estaSupervisor or cantFuncionariosAdentro > 0 or cantFuncionariosEsperandoParaLeer > 0) then
			cantFuncionariosEsperandoParaLeer := cantFuncionariosEsperandoParaLeer + 1;
			leer.wait();
			cantFuncionariosEsperandoParaLeer := cantFuncionariosEsperandoParaLeer - 1;
		end;
		cantFuncionariosAdentro := cantFuncionariosAdentro + 1;
	end;

procedure saleDeLeerFuncionario()
	begin
		cantFuncionariosAdentro := cantFuncionariosAdentro - 1;
		if (supervisorQuiereEntrar) then
			supervisor.signal();
		else if (cantFuncionariosEsperandoParaLeer > 0) then
			modificar.signal();
		else
			leer.signal();
		end;
	end;




end Lote;