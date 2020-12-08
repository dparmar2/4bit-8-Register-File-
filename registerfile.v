//Top level of 4b*8 Register File.
//This is a gate level implementation. 

module RF8_4b_GL
   (
     input  wire [2:0]  wrAddr,  //ip to one decoder
     input  wire [3:0]  wrVal,   //ip to D reg file
     input  wire        wrEn,     //ip to en of D reg file
     input  wire [2:0]  rdAddr,  //ip to second decoder
     output wire [3:0]  rdVal,   //line to op q of d reg file
     input  wire clk             //clock to d reg file
    );
 
  //wire [7:0] wrdc;   //op of write decoder
  //wire [7:0] rddc;               //op of read decoder
  //wire wrEnb;                    //INV wrEn
  wire n0,n1,n2,n3,n4,n5,n6,n7;  //enable lines from anded enable & write decoder
  //wire q00,q01,q02,q03;          //1st row q op
  //wire q10,q11,q12,q13;          //2nd row q op
  //wire q20,q21,q22,q23; //3rd row q op
  //wire q30,q31,q32,q33;          //4th row q op
  //wire q40,q41,q42,q43;          //5th row q op
  //wire q50,q51,q52,q53;          //6th row q op
  //wire q60,q61,q62,q63;          //7th row q op
  //wire q70,q71,q72,q73;          //8th row q op
  //wire m0,m1,m2,m3,m4,m5,m6,m7;  //all output of read decoder
  //wire rd00,rd01,rd02,rd03;         //1st row enable & q anded op
  //wire rd10,rd11,rd12,rd13;         //2nd row enable & q anded op
  //wire rd20,rd21,rd22,rd23; //3rd row enable & q anded op
  //wire rd30,rd31,rd32,rd33;         //4th row enable & q anded op
  //wire rd40,rd41,rd42,rd43;         //5th row enable & q anded op
  //wire rd50,rd51,rd52,rd53;         //6th row enable & q anded op
  //wire rd60,rd61,rd62,rd63;         //7th row enable & q anded op
  //wire rd70,rd71,rd72,rd73;         //8th row enable & q anded op
 
  wire [3:0] qrow0;
  wire [3:0] qrow1;
  wire [3:0] qrow2;
  wire [3:0] qrow3;
  wire [3:0] qrow4;
  wire [3:0] qrow5;
  wire [3:0] qrow6;
  wire [3:0] qrow7;
 
  Decoder_GL unit0(.Y7(n7),.Y6(n6),.Y5(n5),.Y4(n4),.Y3(n3),.Y2(n2),.Y1(n1),.Y0(n0),.A(wrAddr[2]),.B(wrAddr[1]),.C(wrAddr[0]),.En(wrEn));
  MUX8_4b_GL unit1(.A0(qrow0),.A1(qrow1),.A2(qrow2),.A3(qrow3),.A4(qrow4),.A5(qrow5),.A6(qrow6),.A7(qrow7),.S(rdAddr),.Y(rdVal));
 
  //regfile (Q,D,CK,En);
  //1st Row
  regfile r00(qrow0[3],wrVal[3],clk,n0);
  regfile r01(qrow0[2],wrVal[2],clk,n0);
  regfile r02(qrow0[1],wrVal[1],clk,n0);
  regfile r03(qrow0[0],wrVal[0],clk,n0);
 
  //2nd Row
  regfile r10(qrow1[3],wrVal[3],clk,n1);
  regfile r11(qrow1[2],wrVal[2],clk,n1);
  regfile r12(qrow1[1],wrVal[1],clk,n1);
  regfile r13(qrow1[0],wrVal[0],clk,n1);

  //3rd Row
  regfile r20(qrow2[3],wrVal[3],clk,n2);
  regfile r21(qrow2[2],wrVal[2],clk,n2);
  regfile r22(qrow2[1],wrVal[1],clk,n2);
  regfile r23(qrow2[0],wrVal[0],clk,n2);
 
  //4th Row
  regfile r30(qrow3[3],wrVal[3],clk,n3);
  regfile r31(qrow3[2],wrVal[2],clk,n3);
  regfile r32(qrow3[1],wrVal[1],clk,n3);
  regfile r33(qrow3[0],wrVal[0],clk,n3);
 
  //5th Row
  regfile r40(qrow4[3],wrVal[3],clk,n4);
  regfile r41(qrow4[2],wrVal[2],clk,n4);
  regfile r42(qrow4[1],wrVal[1],clk,n4);
  regfile r43(qrow4[0],wrVal[0],clk,n4);
 
  //6th Row
  regfile r50(qrow5[3],wrVal[3],clk,n5);
  regfile r51(qrow5[2],wrVal[2],clk,n5);
  regfile r52(qrow5[1],wrVal[1],clk,n5);
  regfile r53(qrow5[0],wrVal[0],clk,n5);
 
  //7th Row
  regfile r60(qrow6[3],wrVal[3],clk,n6);
  regfile r61(qrow6[2],wrVal[2],clk,n6);
  regfile r62(qrow6[1],wrVal[1],clk,n6);
  regfile r63(qrow6[0],wrVal[0],clk,n6);
 
  //8th Row
  regfile r70(qrow7[3],wrVal[3],clk,n7);
  regfile r71(qrow7[2],wrVal[2],clk,n7);
  regfile r72(qrow7[1],wrVal[1],clk,n7);
  regfile r73(qrow7[0],wrVal[0],clk,n7);
 
endmodule

////////////////////////////////////////////////////////
//Positive edge DFlipflop with MUX for Enable functionality
module regfile (Q,D,CK,En);
  input D,CK,En;
  output Q;
 
  wire mout;
  mux21 m11(mout,En,Q,D);
  dff d11(Q,CK,mout);
 
endmodule

//2:1MUX
module mux21(Ymux,Smux,Imux0,Imux1);
output Ymux;
input Smux,Imux0,Imux1;

wire smuxb,mx0,mx1;

    INV_GT poop1(smuxb,Smux);
    and1 popo(mx0,Imux0,smuxb);
    and1 pop1(mx1,Imux1,Smux);
    or1 pop2(Ymux,mx0,mx1);
endmodule

//DFFlop
module dff(Q,clk,D);
  input D, clk;
  output Q;
 
  wire m0,m1,m2,m3,qb;
 
  NAND2_GT qut1(m2,m1,m0);
  NAND2_GT qut2(m1,m2,clk);
  trinand qut3(m3,m0,m1,clk);
  NAND2_GT qut4(m0,m3,D);
  NAND2_GT qut5(Q,m1,qb);
  NAND2_GT qut6(qb,Q,m3);
endmodule

module trinand(D1,A1,B1,C1);
  output D1;
  input A1,B1,C1;
 
  wire n01, n11;
 
  NAND2_GT i101010(n01,A1,B1);
  INV_GT ilolo(n11,n01);
  NAND2_GT ilosod(D1,C1,n11);
endmodule
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
//3:8Decoder
module Decoder_GL(Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0,A,B,C,En);
  input A,B,C,En;
  output Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0;
 
  wire ab,bb,cb;

INV_GT oo1(ab,A);
INV_GT oo2(bb,B);
INV_GT oo3(cb,C);

and4 oo4(Y0,En,ab,bb,cb);
and4 oo5(Y1,En,ab,bb,C);
and4 oo6(Y2,En,ab,B,cb);
and4 oo7(Y3,En,ab,B,C);
and4 oo8(Y4,En,A,bb,cb);
and4 oo9(Y5,En,A,bb,C);
and4 oo10(Y6,En,A,B,cb);
    and4 oo11(Y7,En,A,B,C);
 
endmodule

module and4(L1,P1,Q1,R1,S1);  //to handle 4 inputs AND logic
  input P1,Q1,R1,S1;
  output L1;
 
  wire l1,l2;
 
  and1 la(l1,P1,Q1);
  and1 lb(l2,R1,S1);
  and1 lc(L1,l1,l2);
 
endmodule
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//For combinatorial read, MUX 8:1 with 4b input
module MUX8_4b_GL
   (
     input  wire [3:0] A0,
     input  wire [3:0] A1,
     input  wire [3:0] A2,
     input  wire [3:0] A3,
     input  wire [3:0] A4,
     input  wire [3:0] A5,
     input  wire [3:0] A6,
     input  wire [3:0] A7,
     input  wire [2:0] S,
     output wire [3:0] Y  );
 
 // wire s2 = S[2]; wire s1 = S[1] ;wire s0 = S[0] //Select inputs
    wire s2b, s1b, s0b;                    //~Select inputs
    wire a00_out,a01_out,a02_out,a03_out;  //A0 all out
    wire a10_out,a11_out,a12_out,a13_out;  //A1 all out
    wire a20_out,a21_out,a22_out,a23_out;  //A2 all out
    wire a30_out,a31_out,a32_out,a33_out;  //A3 all out
    wire a40_out,a41_out,a42_out,a43_out;  //A4 all out
    wire a50_out,a51_out,a52_out,a53_out;  //A5 all out
    wire a60_out,a61_out,a62_out,a63_out;  //A6 all out
    wire a70_out,a71_out,a72_out,a73_out;  //A7 all out
 
 
 
  INV_GT inv1g1 (s0b,S[0]);
  INV_GT inv2g2 (s1b,S[1]);
  INV_GT inv3g3 (s2b,S[2]);
 
  //for A0
  processing proc01 (a00_out,A0[0],s0b,s1b,s2b);
  processing proc02 (a01_out,A0[1],s0b,s1b,s2b);
  processing proc03 (a02_out,A0[2],s0b,s1b,s2b);
  processing proc04 (a03_out,A0[3],s0b,s1b,s2b);
 
  //for A1
  processing proc11 (a10_out,A1[0],s2b,s1b,S[0]);
  processing proc12 (a11_out,A1[1],s2b,s1b,S[0]);
  processing proc13 (a12_out,A1[2],s2b,s1b,S[0]);
  processing proc14 (a13_out,A1[3],s2b,s1b,S[0]);
 
  //for A2
  processing proc21 (a20_out,A2[0],s2b,S[1],s0b);
  processing proc22 (a21_out,A2[1],s2b,S[1],s0b);
  processing proc23 (a22_out,A2[2],s2b,S[1],s0b);
  processing proc24 (a23_out,A2[3],s2b,S[1],s0b);
 
  //for A3
  processing proc31 (a30_out,A3[0],s2b,S[1],S[0]);
  processing proc32 (a31_out,A3[1],s2b,S[1],S[0]);
  processing proc33 (a32_out,A3[2],s2b,S[1],S[0]);
  processing proc34 (a33_out,A3[3],s2b,S[1],S[0]);
 
  //for A4
  processing proc41 (a40_out,A4[0],S[2],s1b,s0b);
  processing proc42 (a41_out,A4[1],S[2],s1b,s0b);
  processing proc43 (a42_out,A4[2],S[2],s1b,s0b);
  processing proc44 (a43_out,A4[3],S[2],s1b,s0b);
 
  //for A5
  processing proc51 (a50_out,A5[0],S[2],s1b,S[0]);
  processing proc52 (a51_out,A5[1],S[2],s1b,S[0]);
  processing proc53 (a52_out,A5[2],S[2],s1b,S[0]);
  processing proc54 (a53_out,A5[3],S[2],s1b,S[0]);
 
  //for A6
  processing proc61 (a60_out,A6[0],S[2],S[1],s0b);
  processing proc62 (a61_out,A6[1],S[2],S[1],s0b);
  processing proc63 (a62_out,A6[2],S[2],S[1],s0b);
  processing proc64 (a63_out,A6[3],S[2],S[1],s0b);
 
  //for A7
  processing proc71 (a70_out,A7[0],S[2],S[1],S[0]);
  processing proc72 (a71_out,A7[1],S[2],S[1],S[0]);
  processing proc73 (a72_out,A7[2],S[2],S[1],S[0]);
  processing proc74 (a73_out,A7[3],S[2],S[1],S[0]);
 
  //for 0th bit
  ored_op oplog0 (Y[0],a00_out,a10_out,a20_out,a30_out,a40_out,a50_out,a60_out,a70_out);
  //for 1st bit
  ored_op oplog1 (Y[1],a01_out,a11_out,a21_out,a31_out,a41_out,a51_out,a61_out,a71_out);
  //for 2nd bit
  ored_op oplog2 (Y[2],a02_out,a12_out,a22_out,a32_out,a42_out,a52_out,a62_out,a72_out);
  //for 3rd bit
  ored_op oplog3 (Y[3],a03_out,a13_out,a23_out,a33_out,a43_out,a53_out,a63_out,a73_out);
 
endmodule
 

module processing(pro_out,w,x,y,z);
  //input is select signal of 3 bits to w,x,y and our bit input An[0].
  //output pro_out goes to the or gate for final stage.  
  input w,x,y,z;
  output pro_out;
  wire pe1, pe2;
 
  and1 an1(pe1,w,x);
  and1 an2(pe2,y,z);
  and1 an3(pro_out,pe1,pe2);
 
endmodule

//for processing all ouputs of processing element to final Y[0]
module ored_op(or_logic_op,g,h,i,j,k,l,m,n);
  input g,h,i,j,k,l,m,n;
  output or_logic_op;
 
  wire orlog1,orlog2,orlog3,orlog4,orlog5,orlog6;
 
  or1 lolol1(orlog1,g,h);
  or1 lolol2(orlog2,i,j);
  or1 lolol3(orlog3,k,l);
  or1 lolol4(orlog4,m,n);
  or1 lolol5(orlog5,orlog1,orlog2);
  or1 lolol6(orlog6,orlog3,orlog4);
  or1 lolol7(or_logic_op,orlog5,orlog6);
 
endmodule
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//cells.sv
module and1(otp,in1,in2);
  output otp;
  input in1,in2;
  wire otp1;
 
  NAND2_GT i101(otp1,in1,in2);
  INV_GT i202(otp,otp1);
 
endmodule

module or1(outp,in3,in4);
  output outp;
  input in3,in4;
  wire otp2;
 
  NOR2_GT i10101(otp2,in3,in4);
  INV_GT i20202(outp,otp2);
 
endmodule


module FA_GT ( CO, S, A, B, CI );
   output CO, S;
   input  A, B, CI;

   wire   n0;
   wire   n1;
   wire   n2;
   
   xor #(12) xor00( S, A, B, CI);

   and I0(n0,  A,  B);  
   and I1(n1,  B, CI);
   and I2(n2, CI,  A);
   
   nor #(10) I3(CO, n0, n1, n2);
   
endmodule

module INV_GT
  (
   Y, A
   );
   output Y;
   input  A;
   
   not #(4) I0(Y,A);
   
endmodule

module TRI_GT
  (
   Y, A, E, Eb
   );
  output Y;
  input E;
  input Eb;
  input A;
   
  notif0 #(6) (Y, A, Eb);
  notif1 #(6) (Y, A,  E);
 
endmodule

module NAND2_GT
  (
   Y, A, B
   );
   output Y;
   input  A;
   input  B;
   
   nand #(4) (Y, A, B);
endmodule

module NOR2_GT
  (
   Y, A, B
   );
   output Y;
   input  A;
   input  B;

   nor #(4) (Y, A, B);
endmodule

module AOI21_GT
  (
   Y, A0, A1, B0
   );

   output Y;
   input  A0;
   input  A1;
   input  B0;
   wire   outA ;

   and I0(outA, A0, A1);
   nor #(8) I1(Y, B0, outA);

endmodule

module AOI22_GT
  (
   Y, A0, A1, B0, B1
   );

   output Y;
   input  A0;
   input  A1;
   input  B0;
   input  B1;

   wire   outA ;
   wire   outB ;


   and I0(outA, A0, A1);
   and I1(outB, B0, B1);
   nor #(8) I2(Y, outA, outB);

endmodule

module OAI21_GT
  (
   Y, A0, A1, B0
   );

   output Y;
   input  A0;
   input  A1;
   input  B0;
   wire   outA ;

   or I0(outA, A0, A1);
   nand #(7) I1(Y, B0, outA);

endmodule

module OAI22_GT
  (
   Y, A0, A1, B0, B1
   );

   output Y;
   input  A0;
   input  A1;
   input  B0;
   input  B1;

   wire   outA ;
   wire   outB ;


   or I0(outA, A0, A1);
   or I1(outB, B0, B1);
   nand #(8) I2(Y, outA, outB);

endmodule

module XOR2_GT
  (
   Y, A, B
   );
   
  output Y;
  input  A;
  input  B;

  xor #(12) I5(Y, A, B);

endmodule
/////////////////////////////////////////////////////////////
