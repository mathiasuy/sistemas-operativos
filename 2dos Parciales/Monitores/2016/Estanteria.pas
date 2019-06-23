Monitor Estanteria;

	var
		inspectorSolicitoAcceso, inspectores, empaquetadoresEnEstanteria : integer;
		empaquetador, inspector : Conditional;

procedure entraEmpaquetador()
	begin
		if (inspectorSolicitoAcceso > 0 or inspectores > 0) then // Se poodría eliminar una de estas 2 variables ya que si bien indican cosas distintas, el fin termina siendo el mismo
		begin
			empaquetador.wait();
		end;
		empaquetadoresEnEstanteria := empaquetadoresEnEstanteria + 1;
	end;

procedure saleEmpaquetador()
	begin
		empaquetadoresEnEstanteria := empaquetadoresEnEstanteria - 1;
		inspector.signal();//Siempre llamo a un inspector antes que nada por si hay uno esperando.
		//No hace falta hacerle signal a otros empaquetadores ya que habrán tantos dormidos como inspectores adentro, por lo cual a medida que se despierten los inspectores, estos despertarán a los empaquetadores.
	end;


procedure entraInspector()
	begin
		inspectorSolicitoAcceso := inspectorSolicitoAcceso + 1;
		if (empaquetadoresEnEstanteria > 0) then
		begin
			inspector.wait();
			inspectorSolicitoAcceso := inspectorSolicitoAcceso - 1;
		end;
	end;


procedure saleInspector()
	begin
		inspectores := inspectores - 1;
		
		if (inspectorSolicitoAcceso > 0) then
			inspector.signal();
		else if (inspectores  == 0) then
			empaquetador.signal();
		end;

	end;

begin
		inspectorSolicitoAcceso = 0;
		inspectores = 0;
		empaquetadoresEnEstanteria = 0;
end;