// Módulo que implementa desplazamientos a izquierda y derecha
module shift_unit(
    input [7:0] A,
    input [3:0] op_sel,
    output [7:0] result
);
    assign result = (op_sel == 4'b1100) ? (A << 1) :    // Shift izquierda
                    (op_sel == 4'b1101) ? (A >> 1) :    // Shift derecha
                    8'b0;
endmodule
