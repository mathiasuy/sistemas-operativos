procedure obtener_pedido() : array [1..20] of integer;
procedure donde_esta() : integer; 
procedure hay_stock(prodcto : integer, estanteria : integer) : boolean;
procedure retirar(producto : integer, estanteria : integer);
procedure finalizar_pedido(ok : boolean);
procedure donde_inspeccionar() : integer;
procedure inspeccionar(estanteria : integer);

procedure entraEmpaquetador()
procedure saleEmpaquetador()
procedure entraInspector()
procedure saleInspector()

var
	estanteria : Monitor;

procedure inspector()
	begin
		while (true)
		begin
			estanteria.entraInspector();
			donde_inspeccionar := donde_inspeccionar(); // Lo pongo luego de entrar al monitor ya que este dato podría cambiar si otro entra  
			inspeccionar(donde_inspeccionar);
			estanteria.saleInspector();
		end;
	end;

procedure empaquetador()
	begin
		while (true)
		begin
			pedidos := obtener_pedido();
			i := 1;
			while (pedidos[i] <> NIL AND i <= 20)
				nroEstanteria := donde_esta(pedidos[i]); // Si hay del producto, siempre estará en ese nro de estantería.
				estanteria[nroEstanteria].entraEmpaquetador();
				if (hay_stock(pedidos[i],nroEstanteria)) then
					retirar(pedidos[i],nroEstanteria);
				else
					estanteria[nroEstanteria].saleInspector();
					finalizar_pedido(fail);// ¿Se supone que esto termina el programa?
				end;
				finalizar_pedido(ok);// ¿Se supone que esto termina el programa?
				estanteria[nroEstanteria].saleInspector();
			end;
		end;
	end;




