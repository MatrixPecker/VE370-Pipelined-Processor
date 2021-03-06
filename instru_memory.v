`timescale 1ns / 1ps

// in stage IF
module instru_memory(
  // input clk,
  input [31:0] addr,
  output reg [5:0] ctr, // [31-26]
  output reg [5:0] funcode, // [5-0]
  // output reg [4:0] read1, // [25-21]
  // output reg [4:0] read2, // [20-16]
  // output reg [4:0] write, // [15-11]
  output reg [31:0] instru // [31-0]
  // output [15:0] num // [15-0]
);

  parameter SIZE_IM = 128; // size of this memory, by default 128*32
  reg [31:0] mem [SIZE_IM-1:0]; // instruction memory

  integer n;
  initial begin
    for(n=0;n<SIZE_IM;n=n+1) begin
      mem[n] = 32'b11111100000000000000000000000000;
    end
    $readmemb("../../../../../testcases/testcase.txt",mem);
    // FIXME: adjust the path to fit your need; or use absolute path instead.
    // $readmemb("../../../../../testcases/testcase.txt",mem); // simulation
    // $readmemb("../../../testcases/testcase.txt",mem); // bitstream
    
    // for(n=0;n<SIZE_IM;n=n+1) begin
    //   $display("[%d] 0x%H",n,mem[n]);
    // end
    instru = 32'b11111100000000000000000000000000;
  end

  always @(*) begin
    if (addr == -4) begin // init
      instru = 32'b11111100000000000000000000000000;
    end else begin
      instru = mem[addr >> 2];
    end
  end
  always @(*)begin
    ctr = instru[31:26];
    funcode = instru[5:0];
    // $display("funcode @ im: 0x%H",funcode);
  end
  // assign num = instru[15:0];

endmodule
