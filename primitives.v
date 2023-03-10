// primitives.v
// Holds pre-designed primitives

primitive udff_r(q, clock, reset_l, data);
   
   output q; reg q;
   input  clock, reset_l, data;
     
   table
      // obtain output on rising edge of clock
      // clock reset_l data q q+
      (01) 1 0 : ? : 0 ;
      (01) 1 1 : ? : 1 ;
      (0?) 1 1 : 1 : 1 ;
      (0?) 1 0 : 0 : 0 ;
      // asynchronous reset_l
      ? 0 ? : ? : 0 ;
      // ignore rising edge of reset_l
      ? R ? : ? : - ;
      // ignore negative edge of clock
      F 1 ? : ? : - ;
      // ignore data changes on steady clock
      ? 1 (??) : ? : - ;
   endtable
   
endprimitive // udff_r


`timescale 1ns / 1ps
`celldefine
module dff_r(q, clock, reset_l, data);
   input clock, reset_l, data;
   output q;

   udff_r(q, clock, reset_l, data);

   specify
      // arc clock --> q
      (posedge clock => ( q +: data )) = (0.1, 0.1);
   endspecify

endmodule // dff_r
`endcelldefine

  
primitive udff(q, clock, data);
   
   output q; reg q;
   input  clock, data;
     
   table
      // obtain output on rising edge of clock
      // clock data q q+
      (01) 0 : ? : 0 ;
      (01) 1 : ? : 1 ;
      (0?) 1 : 1 : 1 ;
      (0?) 0 : 0 : 0 ;
      // ignore negative edge of clock
      F ? : ? : - ;
      // ignore data changes on steady clock
      ? (??) : ? : - ;
   endtable
   
endprimitive // u_dff
  

`timescale 1ns / 1ps
`celldefine
module dff(q, clock, data);
   input clock, data;
   output q;

   udff(q, clock, data);

   specify
      // arc clk --> q
      (posedge clock => ( q +: data )) = (0.1, 0.1);
   endspecify
   
endmodule // udff
`endcelldefine

  
module u_mux2(out, in0, in1, sel);
   output out;
   input in0, in1, sel;

   wire  nsel, w1, w0;
   not NOT0(nsel, sel);

   and AND0(w0, nsel, in0);
   and AND1(w1, sel, in1);

   or OR0(out, w1, w0);
endmodule // u_mux2


  `celldefine
module scanff(CK, SD, SI, SE, Q);
   input CK, SD, SI, SE;
   output Q;
   wire   a;
   dff  DFF_SCAN(Q, CK, a);  
   u_mux2  U_MUX2_SCAN(a, SD, SI, SE);
 
endmodule // scanff
`endcelldefine