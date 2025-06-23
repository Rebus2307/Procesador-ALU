// Módulo que implementa operaciones lógicas: AND, OR, XOR, NOT
module logic_unit(
    input [7:0] A, B,
    input [3:0] op_sel,
    output [7:0] result
);
    assign result = (op_sel == 4'b0011) ? (A & B) :     // AND
                    (op_sel == 4'b0100) ? (A | B) :     // OR
                    (op_sel == 4'b0101) ? (A ^ B) :     // XOR
                    (op_sel == 4'b0110) ? (~A) :        // NOT (solo A)
                    8'b0;
endmodule
