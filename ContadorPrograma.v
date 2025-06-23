module ContadorPrograma (
    input  wire        CLK,        // Pulso de reloj (Botón)
    input  wire        RESET,
    input  wire        WPC,        // Escribir en CP
    input  wire        ALU,        // Valor condicional de ALU
    input  wire        UC,         // Valor condicional de UC
    input  wire [10:0] DIN,
    output reg  [10:0] DOUT,
    output reg         LED_WPC,
    output reg         LED_ALU,
    output reg         LED_UC
);

    reg [10:0] CP_REG;
    wire [10:0] SUMA;
    wire SALTO;

    // CP + 1 (siguiente instrucción)
    assign SUMA = CP_REG + 11'd1;

    // Salto condicional o directo
    assign SALTO = ALU | UC;

    always @(negedge CLK or posedge RESET) begin
        if (RESET) begin
            CP_REG   <= 11'd0;
            LED_WPC  <= 1'b0;
            LED_ALU  <= 1'b0;
            LED_UC   <= 1'b0;
        end else begin
            // Apagar LEDs por defecto
            LED_WPC <= 1'b0;
            LED_ALU <= 1'b0;
            LED_UC  <= 1'b0;

            if (WPC) begin
                LED_WPC <= 1'b1; // Encender solo en este ciclo
                if (SALTO) begin
                    CP_REG  <= DIN;
                    LED_ALU <= ALU;
                    LED_UC  <= UC;
                end else begin
                    CP_REG <= SUMA;
                end
            end
        end
    end

    // Salida del contador
    always @(*) begin
        DOUT = CP_REG;
    end

endmodule
