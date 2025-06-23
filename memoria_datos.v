// memoria_datos.v
module memoria_datos (
    input  wire         clk,    // reloj
    input  wire [7:0]   addr,   // dirección de 8 bits
    input  wire [10:0]  din,    // dato de escritura de 11 bits
    input  wire         we,     // enable de escritura
    output reg  [10:0]  dout    // dato de lectura de 11 bits
);

  // 256 palabras de 11 bits
  reg [10:0] mem [0:255];

  integer i;
  initial begin
    // inicialización explícita de las dos primeras posiciones
    mem[0] = 11'b00000000000;  // dirección 0
    mem[1] = 11'b00000101010;  // dirección 1 = 42 decimal (ejemplo)
    // resto a cero
    for (i = 2; i < 256; i = i + 1) begin
      mem[i] = 11'b00000000000;
    end
  end

  // Escritura síncrona al flanco de subida de clk
  always @(posedge clk) begin
    if (we) begin
      mem[addr] <= din;
    end
  end

  // Lectura asíncrona (combinacional)
  always @(*) begin
    dout = mem[addr];
  end

endmodule
