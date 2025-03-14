`timescale 1ns/1ps

module alu_tb();
    reg clk, rst;
    reg [31:0] A, B;
    reg [2:0] alu_ctrl;
    wire [31:0] result;

    // Instantiate ALU
    alu DUT(.clk(clk), .rst(rst), .A(A), .B(B), .alu_ctrl(alu_ctrl), .result(result));

    // Generate clock signal (period = 10ns -> 100MHz)
    always #5 clk = ~clk;

    // Simulation process
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, alu_tb);

        // Initialize signals
        clk = 0;
        rst = 1;
        A = 0;
        B = 0;
        alu_ctrl = 0;

        // Reset sequence
        #10 rst = 0;

        // Apply test cases
        #10 A = 32'd10; B = 32'd5; alu_ctrl = 3'b000; // ADD
        #10 $display("ADD: %d + %d = %d", A, B, result);
        
        #10 alu_ctrl = 3'b001; // SUB
        #10 $display("SUB: %d - %d = %d", A, B, result);
        
        #10 alu_ctrl = 3'b010; // AND
        #10 $display("AND: %b & %b = %b", A, B, result);
        
        #10 alu_ctrl = 3'b011; // OR
        #10 $display("OR: %b | %b = %b", A, B, result);
        
        #10 alu_ctrl = 3'b100; // NOT (only A is considered)
        #10 $display("NOT: ~%b = %b", A, result);
        
        #10 alu_ctrl = 3'b101; // Undefined operation (default case)
        #10 $display("DEFAULT CASE: Unexpected OpCode %b, result = %h", alu_ctrl, result);
        
        // Finish simulation
        #10 $finish;
    end
endmodule

