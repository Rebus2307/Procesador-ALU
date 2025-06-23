// Módulo que implementa comparaciones entre A y B
module cmp_unit(
    input [7:0] A, B,
    input [3:0] op_sel,
    output [7:0] result
);
    assign result = (op_sel == 4'b0111) ? (A == B ? 8'b1 : 8'b0) :       // Igual
                    (op_sel == 4'b1001) ? (A != B ? 8'b1 : 8'b0) :       // Diferente
                    (op_sel == 4'b1010) ? (A > B ? 8'b1 : 8'b0) :        // Mayor que
                    (op_sel == 4'b1011) ? (A < B ? 8'b1 : 8'b0) :        // Menor que
                    (op_sel == 4'b1110) ? (A >= B ? 8'b1 : 8'b0) :       // Mayor o igual
                    (op_sel == 4'b1111) ? (A <= B ? 8'b1 : 8'b0) :       // Menor o igual
                    8'b0;
endmodule
