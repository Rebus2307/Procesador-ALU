module memoria_programa (
    input  wire [10:0] addr,
    output reg  [21:0] data
);

// ========== OPCODES ==========
localparam [4:0]
    OPCODE_LW    = 5'b00000,  // Carga
    OPCODE_ADD   = 5'b00001,  // Suma
    OPCODE_SUB   = 5'b00010,  // Resta
    OPCODE_MULT  = 5'b00011,  // Multiplicación
    OPCODE_DIV   = 5'b00100,  // División
    OPCODE_AND   = 5'b00101,  // AND
    OPCODE_OR    = 5'b00110,  // OR
    OPCODE_XOR   = 5'b00111,  // XOR
    OPCODE_NOT   = 5'b01000,  // NOT
    OPCODE_EQ    = 5'b01001,  // Igualdad
    OPCODE_NEQ   = 5'b01010,  // Diferente
    OPCODE_GT    = 5'b01011,  // Mayor que
    OPCODE_LT    = 5'b01100,  // Menor que
    OPCODE_SLL   = 5'b01101,  // Desplazamiento a la izquierda
    OPCODE_SRL   = 5'b01110,  // Desplazamiento a la derecha
    OPCODE_GE    = 5'b01111,  // Mayor o igual
    OPCODE_LE    = 5'b10000,  // Menor o igual

    OPCODE_ADDI  = 5'b01001,  // Suma inmediata
    OPCODE_SUBI  = 5'b01010,  // Resta inmediata
    OPCODE_MULTI = 5'b01011,  // Multiplicación inmediata
    OPCODE_DIVI  = 5'b01100,  // División inmediata
    OPCODE_BNEI  = 5'b01101,  // Salto si es diferente (I)

    OPCODE_SW    = 5'b10000,  // Almacenamiento
    OPCODE_BNEQ  = 5'b10001,  // Salto condicional (J)
    OPCODE_B     = 5'b10010,  // Salto incondicional (J)
    OPCODE_NOP   = 5'b11111;  // No operación

// ========== REGISTROS ==========
localparam [2:0]
    R0 = 3'b000,
    R1 = 3'b001,
    R2 = 3'b010,
    R3 = 3'b011,
    R4 = 3'b100,
    R5 = 3'b101,
    R6 = 3'b110,
    R7 = 3'b111;

// ========== INMEDIATOS ==========
localparam [2:0]
    IMM1 = 3'b001,
    IMM2 = 3'b011;

// ========== CAMPO RESULTANTE ==========
localparam [4:0] CR  = 5'b00000;

always @(*) begin
    case (addr)

        // --- TRANSFERENCIA DE DATOS (LW y SW) ---
        11'd0: data = {OPCODE_LW, R0, 3'b000, 11'd0};   // LW r0, su, dir=0
        11'd1: data = {OPCODE_LW, R1, 3'b000, 11'd1};   // LW r1, su, dir=1
        11'd2: data = {OPCODE_SW, 3'b000, R1, 11'd2};   // SW su, r1, dir=2

        // --- TIPO R ---
        11'd3: data = {OPCODE_MULT, R1, R2, 6'd3, CR};  // MULT r1, r2 -> r3
        11'd4: data = {OPCODE_ADD,  R3, R1, 6'd4, CR};  // ADD  r3, r1 -> r4
        11'd5: data = {OPCODE_SUB,  R0, R1, 6'd0, CR};  // SUB  r0, r1 -> r0

        // --- TIPO I ---
        11'd6: data = {OPCODE_ADDI, IMM1, IMM2, 6'd5, CR}; // ADDI imm1 + imm2 -> r5
        11'd7: data = {OPCODE_SUBI, IMM2, IMM1, 6'd6, CR}; // SUBI imm2 - imm1 -> r6

        // --- TIPO J (SALTOS) ---
        11'd8:  data = {OPCODE_BNEQ, R1, R2, 11'd12};      // BNEQ r1 != r2 -> PC = 12
        11'd9:  data = {OPCODE_B,    3'b000, 3'b000, 11'd20}; // B salto incondicional -> PC = 20

        default: data = 22'b0000000000000000000000; // NOP
    endcase
end

endmodule
