// Módulo multiplexor para seleccionar el resultado final de la ALU
module alu_mux(
    input [7:0] arith_res,
    input [7:0] logic_res,
    input [7:0] cmp_res,
    input [7:0] shift_res,
    input [3:0] op_sel,
    output [7:0] result
);
    assign result = (op_sel <= 4'b0010 || op_sel == 4'b1000) ? arith_res :        // Aritmética
                    (op_sel >= 4'b0011 && op_sel <= 4'b0110) ? logic_res :        // Lógica
                    (op_sel >= 4'b0111 && op_sel <= 4'b1111 &&
                     op_sel != 4'b1100 && op_sel != 4'b1101) ? cmp_res :          // Comparación
                    ((op_sel == 4'b1100 || op_sel == 4'b1101) ? shift_res : 8'b0);// Desplazamiento
endmodule
