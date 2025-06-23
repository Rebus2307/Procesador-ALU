// Módulo de banderas
module flags(
    input [7:0] result,
    input overflow_in,    // De la operación aritmética
    input carry_in,       // Último carry (C[8] del sumador/restador)
    input [3:0] op_sel,   // Selector de operación
    output reg carry_flag,
    output zero_flag,
    output reg overflow_flag,
    output negative_flag
);
    // La bandera de cero se activa si el resultado es cero
    // Pero solo si NO hay desbordamiento
    assign zero_flag = (result == 8'b0) & ~overflow_in;
    
    // La bandera de negativo se activa si el bit más significativo es 1
    assign negative_flag = result[7];
    
    // Configuración de las banderas de acarreo y desbordamiento según la operación
    always @(*) begin
        case (op_sel)
            4'b0000: begin  // Suma
                carry_flag = carry_in;
                overflow_flag = overflow_in;
            end
            4'b0001: begin  // Multiplicación
                carry_flag = carry_in;
                overflow_flag = carry_in;  // Overflow si hay carry en multiplicación
            end
            4'b0010: begin  // División 
                carry_flag = 1'b0;  // No hay carry en división
                overflow_flag = 1'b0;  // No consideramos overflow en división
            end
            4'b1000: begin  // Resta
                carry_flag = carry_in;
                overflow_flag = overflow_in;
            end
            4'b1100, 4'b1101: begin  // Desplazamientos
                // Para desplazamiento a la izquierda, el carry es el bit que se pierde
                // Para desplazamiento a la derecha, normalmente no hay carry
                carry_flag = (op_sel == 4'b1100) ? result[7] : 1'b0;
                overflow_flag = 1'b0;
            end
            default: begin
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
        endcase
    end
endmodule