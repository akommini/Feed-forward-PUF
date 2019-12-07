.GLOBAL vss! vdd!

.include '/home/akommini/658proj/NMOS32LP.inc'
.include '/home/akommini/658proj/PMOS32LP.inc'
vsupply vdd! 0 1.0
vss vss! 0 0
.vec 'Test90_90.vec'


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


**upper mux
m6 net16 a vss! vss! NMOS_VTL L=40e-9 W=90e-9
m5 n1 s net16 vss! NMOS_VTL L=40e-9 W=90e-9 
m4 n1 a vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m3 n1 s vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m1 invo s vss! vss! NMOS_VTL L=40e-9 W=90e-9 
m2 invo s vdd! vdd! PMOS_VTL L=40e-9 W=180e-9 
m7 net17 b vss! vss! NMOS_VTL L=40e-9 W=90e-9
m8 n2 invo net17 vss! NMOS_VTL L=40e-9 W=90e-9 
m9 n2 b vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m10 n2 invo vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m11 net18 n1 vss! vss! NMOS_VTL L=40e-9 W=90e-9
m12 n3 n2 net18 vss! NMOS_VTL L=40e-9 W=90e-9 
m13 n3 n2 vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m14 n3 n1 vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m15 net19 b vss! vss! NMOS_VTL L=40e-9 W=90e-9
m16 n4 s net19 vss! NMOS_VTL L=40e-9 W=90e-9 
m17 n4 b vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m18 n4 s vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m21 net20 a vss! vss! NMOS_VTL L=40e-9 W=90e-9
m22 n5 invo net20 vss! NMOS_VTL L=40e-9 W=90e-9 
m23 n5 a vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m24 n5 invo vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m25 net21 n4 vss! vss! NMOS_VTL L=40e-9 W=90e-9
m26 n6 n5 net21 vss! NMOS_VTL L=40e-9 W=90e-9 
m27 n6 n5 vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
m28 n6 n4 vdd! vdd! PMOS_VTL L=40e-9 W=90e-9 
x1 n3 n6 ya yb Arbiter













