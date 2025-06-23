module banco_registros (
    input wire clk,
    input wire we,
    input wire [2:0] addr_wr,
    input wire [2:0] addr_rd1,
    input wire [2:0] addr_rd2,
    input wire [7:0] din,
    output wire [7:0] dout1,
    output wire [7:0] dout2
);

    // Declaración de la memoria: 8 registros de 8 bits
    reg [7:0] mem [0:7];

    // Escritura sincrónica en flanco de subida del reloj
    always @(posedge clk) begin
        if (we) begin
            mem[addr_wr] <= din;
        end
    end

    // Lectura combinacional (doble lectura)
    assign dout1 = mem[addr_rd1];
    assign dout2 = mem[addr_rd2];

endmodule
