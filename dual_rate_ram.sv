parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 3;
parameter DEPTH = 8;

module dual_rate_ram(
input logic [DATA_WIDTH-1:0] data_in_a,data_in_b,
input logic [ADDR_WIDTH-1:0] addr_a,addr_b,
input logic clk_a,clk_b,
input logic wre_a,wre_b,
input logic chipe_a,chipe_b,
input logic nrst_a,nrst_b,

output logic [DATA_WIDTH-1:0] data_out_a,data_out_b
);

logic [DATA_WIDTH-1:0] ram [DEPTH-1:0];

initial begin
    integer i;
    for(i=0;i<DEPTH;i=i+1)
    begin

      ram[i]={DATA_WIDTH{1'b0}};
     
    end

end
    always_ff @( posedge clk_a ) begin : PORT_A

   if(~nrst_a)
   data_out_a <= {DATA_WIDTH{1'b0}};
   else if(chipe_a)
   begin
    if(wre_a)
    ram[addr_a]<=data_in_a;
    else
    data_out_a<=ram[addr_a];
   end
end



    always_ff @( posedge clk_b ) begin : PORT_B

   if(~nrst_b)
   data_out_b <= {DATA_WIDTH{1'b0}};
   else if(chipe_b)
   begin
    if(wre_b)
    ram[addr_b]<=data_in_b;
    else
    data_out_b<=ram[addr_b];
   end
end




endmodule
