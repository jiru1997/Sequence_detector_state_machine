module seq_detector(output z, 
	                input  x, 
	                input  clk, 
	                input  reset);

    reg[2:0] state, nextstate;
    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;

    always@(posedge clk or negedge reset) begin
      if(!reset) begin
        state <= s0;
        nextstate <= s0;
      end 
      else begin
        state <= nextstate;
      end 
    end

    always@(*) begin
      case(state)
        s0: if(x) nextstate = s1; else nextstate = s0;
        s1: if(x) nextstate = s1; else nextstate = s2;
        s2: if(x) nextstate = s3; else nextstate = s0;
        s3: if(x) nextstate = s4; else nextstate = s2;
        s4: if(x) nextstate = s1; else nextstate = s2;
        default: nextstate = s0;
      endcase
    end

    always@(posedge clk or negedge reset) begin
      case(state) 
        s4: if(x) z = 1'b0; else z = 1'b1;
        default: z = 1'b0;
      endcase
endmodule
