//Sumador completo 1 bit
module full_adder(
	input a, b, cin,
	output sum, cout
);
	wire Sint1, Cint1, Cint2; //Conexiones internas
	
	//Primer medio sumador
	half_adder ha1(
		.a(a),
		.b(b),
		.sum(Sint1),
		.carry(Cint1)
	);
	
	//Segundo medio sumador 
	half_adder ha2(
		.a(Sint1),
		.b(cin),
		.sum(sum),
		.carry(Cint2)
	);
	assign cout = Cint1|Cint2; //OR
endmodule