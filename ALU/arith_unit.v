// Módulo que implementa operaciones aritméticas con signo: suma, resta, multiplicación y división
module arith_unit(
    input signed [7:0] A, B,
    input [3:0] op_sel,
    output reg [7:0] result,
    output reg carry_out,
    output reg overflow_out
);
    wire signed [7:0] sum_res;
    wire signed [15:0] mult_res;
    wire signed [7:0] div_res;
    wire overflow_sresta;

    // Sumador/restador modular (ya compatible con signed)
    sumador_restador_8bits sr8(
        .Ai(A),
        .Bi(B),
        .SL(op_sel[3]),     // Suma (0) o resta (1)
        .So(sum_res),
        .overflow(overflow_sresta)
    );

    // Multiplicación y división como signed
    assign mult_res = A * B;
    assign div_res = (B != 0) ? (A / B) : 8'sd0;

    always @(*) begin
        // Valores por defecto
        result = 8'd0;
        carry_out = 1'b0;
        overflow_out = 1'b0;

        case (op_sel)
            4'b0000: begin // Suma
                result = sum_res;
                overflow_out = overflow_sresta;
                carry_out = (A[7] == B[7]) && (sum_res[7] != A[7]); // Desbordamiento en suma signed
            end
            4'b1000: begin // Resta
                result = sum_res;
                overflow_out = overflow_sresta;
                carry_out = (A[7] != B[7]) && (sum_res[7] != A[7]); // Desbordamiento en resta signed
            end
            4'b0001: begin // Multiplicación
                result = mult_res[7:0]; // Parte baja del producto
                carry_out = (mult_res > 127 || mult_res < -128); // Si no cabe en 8 bits signed
            end
            4'b0010: begin // División
                if (B != 0) begin
                    result = div_res;
                end else begin
                    result = 8'd0;
                    carry_out = 1'b1; // Error lógico: división por cero
                end
            end
            default: begin
                result = 8'd0;
            end
        endcase
    end
endmodule
