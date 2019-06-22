Monitor Tanque;
	var
		cantBebida 						: integer;//Maximo 5L, se llena de a 500mL por lo que no permitiré más de 10 colocados
		descargaBebida 					: conditional;
		finLlenarLata 					: conditional;
		inspectorEsperando				: conditional;
		libre 							: boolean;
		inspectorQuiereEntrar			: boolean;
		hayMaquinaDeEmbotellarEsperando	: integer;
		hayMaquinaDeGenerarEsperando	: integer;
	
	procedure comienzoColocarBebida() 
	begin
		if (not libre or cantBebida == 10 or inspectorQuiereEntrar) then
			hayMaquinaDeGenerarEsperando++;//Esto es solo para que, cuando alguien despierte a alguien, se fije antes si hay alguien para despertar ya que solo puede elegir a uno y por lo tanto esa chance tiene que ocuparla en quien lo precise
			descargaBebida.wait();
			hayMaquinaDeGenerarEsperando--;
		end;
		libre := false; //Ahora estará ocupado hasta que se declare el fin de la colocación.
	end;

	procedure finColocarBebida() //Acá ya sé que se libera un lugar por lo que no hace falta chequearlo
	begin
		libre := true;
		cantBebida++;
		//Llamo al quien corresponda...
		if (inspectorQuiereEntrar) then
			inspectorEsperando.signal();
		else if (cantBebida < 10 AND hayMaquinaDeGenerarEsperando > 0) then
			descargaBebida.signal();
		else if (cantBebida > 0)
			llenarLata.signal();
		end;
	end;

	procedure comienzoLlenarLata()
	begin
		if (not libre or cantBebida == 0 or inspectorQuiereEntrar) then
			hayMaquinaDeEmbotellarEsperando++;
			llenarLata.wait();
			hayMaquinaDeEmbotellarEsperando--;
		end;
		libre := false;
	end;

	procedure finLlenarLata()
	begin
		cantBebida--;
		libre := true;
		if (inspectorQuiereEntrar) then
			inspectorEsperando.signal();
		else if (cantBebida > 0 AND hayMaquinaDeEmbotellarEsperando > 0) then
			llenarLata.signal();
		else if (cantBebida < 10)
			descargaBebida.signal();
		end;
	end;

	procedure comienzoInsepccionar()
	begin
		inspectorQuiereEntrar := true;
		if (not libre or cantBebida == 0) then
			inspectorEsperando.wait();
		end;	
		libre := false;
	end;

	procedure finInsepccionar()
	begin
		inspectorQuiereEntrar := false;
		libre := false;
		if (cantBebida > 0 AND hayMaquinaDeEmbotellarEsperando > 0) then
			llenarLata.signal();
		else if (cantBebida < 10)
			descargaBebida.signal();//si no había una esperando no importa, el signal no hará nada...
		end;

	end;
begin
	inspectorQuiereEntrar = false;
	libre = true;
	cantBebida = 0;
	hayMaquinaDeEmbotellarEsperando = 0;
	hayMaquinaDeGenerarEsperando = 0;
end program;


