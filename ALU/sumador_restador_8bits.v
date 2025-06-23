//Sumador restador 8 bits
module sumador_restador_8bits(
    input [7:0] Ai,
    input [7:0] Bi,
    input SL,            //Selector de operacion 0:Suma, 1:resta
    output [7:0] So,
    output overflow
);
    wire [7:0] B_complemento;
    wire [8:0] C;
    wire xnor_result;
    wire [7:0] fa_sum_outputs;
    
    //Complemento de B para resta
    genvar i;
    generate 
        for(i=0; i<8; i=i+1) begin:complemento_b
            assign B_complemento[i] = Bi[i]^SL;    //XOR para cada bit
        end
    endgenerate
    
    //Inicializacion acarreo de entrada
    assign C[0] = SL;        //Para suma:0
    
    //Instancia de los 8 sumadores completos
    genvar j;
    generate 
        for (j=0; j<8; j=j+1) begin:sumadores
            full_adder fa(
                .a(Ai[j]),
                .b(B_complemento[j]),
                .cin(C[j]),
                .sum(fa_sum_outputs[j]),    //Guardamos las salidas en cables intermedios
                .cout(C[j+1])
            );
        end
    endgenerate
    
    //XNOR entre el último y penúltimo acarreo
    assign xnor_result = ~(C[8]^C[7]);    //XNOR
    
    //AND entre las salidas de los sumadores y el resultado de la XNOR
    genvar k;
    generate
        for (k=0; k<8; k=k+1) begin:and_gates
            assign So[k] = fa_sum_outputs[k] & xnor_result;
        end
    endgenerate
    
    //Desbordamiento
    assign overflow = C[8]^C[7];    //XOR
endmodule