// Módulo principal de la ALU que conecta unidades aritméticas, lógicas, de comparación y desplazamiento
module alu(
    input [7:0] A,             // Operando A
    input [7:0] B,             // Operando B
    input [3:0] OP_SEL,        // Selector de operación
    output [7:0] RESULT,       // Resultado final
    output CARRY_FLAG,         // Bandera de acarreo
    output ZERO_FLAG,          // Bandera de resultado cero
    output OVERFLOW_FLAG,      // Bandera de desbordamiento
    output NEGATIVE_FLAG       // Bandera de número negativo
);

    // Resultados parciales de cada unidad
    wire [7:0] arith_result;
    wire [7:0] logic_result;
    wire [7:0] cmp_result;
    wire [7:0] shift_result;
    wire [7:0] final_result;

    // Banderas internas de aritmética
    wire carry_flag_arith;
    wire overflow_flag_arith;

    // Unidad aritmética (suma, resta, mult, div)
    arith_unit arith(
        .A(A),
        .B(B),
        .op_sel(OP_SEL),
        .result(arith_result),
        .carry_out(carry_flag_arith),
        .overflow_out(overflow_flag_arith)
    );

    // Unidad lógica (AND, OR, XOR, NOT)
    logic_unit logics(
        .A(A),
        .B(B),
        .op_sel(OP_SEL),
        .result(logic_result)
    );

    // Unidad de comparación (==, !=, >, <, >=, <=)
    cmp_unit comparator(
        .A(A),
        .B(B),
        .op_sel(OP_SEL),
        .result(cmp_result)
    );

    // Unidad de desplazamiento (<<, >>)
    shift_unit shifter(
        .A(A),
        .op_sel(OP_SEL),
        .result(shift_result)
    );

    // Multiplexor para seleccionar la salida según OP_SEL
    alu_mux mux(
        .arith_res(arith_result),
        .logic_res(logic_result),
        .cmp_res(cmp_result),
        .shift_res(shift_result),
        .op_sel(OP_SEL),
        .result(final_result)
    );

    // Resultado final
    assign RESULT = final_result;

    // Módulo de banderas (Zero, Carry, Overflow, Negative)
    flags flags_module(
        .result(final_result),
        .overflow_in(overflow_flag_arith),
        .carry_in(carry_flag_arith),
        .op_sel(OP_SEL),
        .carry_flag(CARRY_FLAG),
        .zero_flag(ZERO_FLAG),
        .overflow_flag(OVERFLOW_FLAG),
        .negative_flag(NEGATIVE_FLAG)
    );

endmodule
