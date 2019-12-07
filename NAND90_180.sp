.GLOBAL vss! vdd!

.include '/home/akommini/658proj/NMOS32LP.inc'
.include '/home/akommini/658proj/PMOS32LP.inc'
vsupply vdd! 0 1.0
vss vss! 0 0
.vec 'Test90_90.vec'
vclock clk 0 PWL (0 0 3.49n 0 3.5n 1.1 3.9n 1.1)

.TEMP 25
.OPTION POST

** Library name: NangateOpenCellLibrary
** Cell name: NAND2_X1
** View name: schematic
.subckt NAND2_X1 a1 a2 zn
m_i_3 zn a2 vdd! vdd! PMOS_VTL L=40e-9 W=630e-9
m_i_2 vdd! a1 zn vdd! PMOS_VTL L=40e-9 W=630e-9
m_i_0 zn a1 net_0 vss! NMOS_VTL L=40e-9 W=415e-9
m_i_1 net_0 a2 vss! vss! NMOS_VTL L=40e-9 W=415e-9
.ends NAND2_X1
** End of subcircuit definition.

** Library name: NangateOpenCellLibrary
** Cell name: INV_X1
** View name: schematic
.subckt INV_X1 a zn
m_i_0 zn a vss! vss! NMOS_VTL L=40e-9 W=415e-9
m_i_1 zn a vdd! vdd! PMOS_VTL L=40e-9 W=630e-9
.ends INV_X1
** End of subcircuit definition.

** Library name: FFPUF_SCA
** Cell name: Arbiter
** View name: schematic
.subckt Arbiter a b y_a y_b
xi1 net6 b net5 NAND2_X1
xi0 net5 a net6 NAND2_X1
xi5 net5 y_b INV_X1
xi4 net6 y_a INV_X1
.ends Arbiter
** End of subcircuit definition.


** Library name: NangateOpenCellLibrary
** Cell name: DFF_X1
** View name: schematic
.subckt DFF_X1 ck d q qn
m_mn3 z2 d vss! vss! NMOS_VTL L=40e-9 W=275e-9
m_mn4 z2 cni z3 vss! NMOS_VTL L=40e-9 W=275e-9
m_mn6 vss! z4 z6 vss! NMOS_VTL L=40e-9 W=90e-9
m_mn7 z3 ci z6 vss! NMOS_VTL L=40e-9 W=90e-9
m_mn1 vss! ck cni vss! NMOS_VTL L=40e-9 W=210e-9
m_mn8 z12 z3 vss! vss! NMOS_VTL L=40e-9 W=210e-9
m_mn9 z9 ci z12 vss! NMOS_VTL L=40e-9 W=210e-9
m_mn12 z9 cni z8 vss! NMOS_VTL L=40e-9 W=90e-9
m_mn11 z8 z10 vss! vss! NMOS_VTL L=40e-9 W=90e-9
m_mn14 qn z9 vss! vss! NMOS_VTL L=40e-9 W=415e-9
m_mn13 vss! z10 q vss! NMOS_VTL L=40e-9 W=415e-9
m_mn5 z4 z3 vss! vss! NMOS_VTL L=40e-9 W=210e-9
m_mn2 ci cni vss! vss! NMOS_VTL L=40e-9 W=210e-9
m_mn10 vss! z9 z10 vss! NMOS_VTL L=40e-9 W=210e-9
m_mp4 z3 ci z5 vdd! PMOS_VTL L=40e-9 W=420e-9
m_mp3 z5 d vdd! vdd! PMOS_VTL L=40e-9 W=420e-9
m_mp7 z1 cni z3 vdd! PMOS_VTL L=40e-9 W=90e-9
m_mp6 vdd! z4 z1 vdd! PMOS_VTL L=40e-9 W=90e-9
m_mp1 vdd! ck cni vdd! PMOS_VTL L=40e-9 W=315e-9
m_mp8 z7 z3 vdd! vdd! PMOS_VTL L=40e-9 W=315e-9
m_mp9 z9 cni z7 vdd! PMOS_VTL L=40e-9 W=315e-9
m_mp12 z9 ci z11 vdd! PMOS_VTL L=40e-9 W=90e-9
m_mp11 z11 z10 vdd! vdd! PMOS_VTL L=40e-9 W=90e-9
m_mp14 qn z9 vdd! vdd! PMOS_VTL L=40e-9 W=630e-9
m_mp13 vdd! z10 q vdd! PMOS_VTL L=40e-9 W=630e-9
m_mp5 z4 z3 vdd! vdd! PMOS_VTL L=40e-9 W=315e-9
m_mp2 ci cni vdd! vdd! PMOS_VTL L=40e-9 W=315e-9
m_mp10 vdd! z9 z10 vdd! PMOS_VTL L=40e-9 W=315e-9
.ends DFF_X1
** End of subcircuit definition.


**upper mux
m6 net16 a vss! vss! NMOS_VTL L=40e-9 W=90e-9
m5 n1 s net16 vss! NMOS_VTL L=40e-9 W=90e-9 
m4 n1 a vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m3 n1 s vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m1 invo s vss! vss! NMOS_VTL L=40e-9 W=90e-9 
m2 invo s vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m7 net17 b vss! vss! NMOS_VTL L=40e-9 W=90e-9
m8 n2 invo net17 vss! NMOS_VTL L=40e-9 W=90e-9 
m9 n2 b vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m10 n2 invo vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m11 net18 n1 vss! vss! NMOS_VTL L=40e-9 W=90e-9
m12 n3 n2 net18 vss! NMOS_VTL L=40e-9 W=90e-9 
m13 n3 n2 vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m14 n3 n1 vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
**lower mux
m15 net19 b vss! vss! NMOS_VTL L=40e-9 W=90e-9
m16 n4 s net19 vss! NMOS_VTL L=40e-9 W=90e-9 
m17 n4 b vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m18 n4 s vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m21 net20 a vss! vss! NMOS_VTL L=40e-9 W=90e-9
m22 n5 invo net20 vss! NMOS_VTL L=40e-9 W=90e-9 
m23 n5 a vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m24 n5 invo vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m25 net21 n4 vss! vss! NMOS_VTL L=40e-9 W=90e-9
m26 n6 n5 net21 vss! NMOS_VTL L=40e-9 W=90e-9 
m27 n6 n5 vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m28 n6 n4 vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
x1 n3 n6 ya yb Arbiter
x2 clk ya out outb DFF_X1
.tran 0.01ps 10ns
.MEASURE TRAN tdlayS1a1 TRIG V(n3) VAL = 0.5 RISE = 1 TD=0.5ns TARG V(n6) VAL = 0.5 RISE = 1
.MEASURE TRAN PowEva1 INTEG I(vsupply) From=0.52ns TO=3.99ns
.MEASURE TRAN PowEva3Half1 INTEG I(vsupply) From=3.25ns TO=3.75ns
.MEASURE TRAN ya1 AVG V(ya) FROM=3.991ns TO=3.9911ns
.MEASURE TRAN outa1 AVG V(out) FROM=3.991ns TO=3.9911ns
.IC I(vsupply)=0 V(a)=0 V(b)=0 V(ya)=0 V(out)=0
**.PRINT TRAN I(vsupply)
.end












