
.GLOBAL vss vdd
.include '/home/akommini/658proj/nmos.inc'
.include '/home/akommini/658proj/pmos.inc'
vsupply vdd 0 1.0
vss vss 0 0
.vec 'arbvec.vec'
.TEMP 25
.OPTION POST


** Library name: Project_658
** Cell name: Arbiter
** View name: schematic
**.subckt Arbiter d1 d2 q vdd vss
**m12 _net0 _net1 vss vss nmos L=40e-9 W=90e-9
**m5 q out vss vss nmos L=40e-9 W=90e-9
m3 net5 d2 vss vss nmos L=40e-9 W=90e-9
m2 _net1 out net5 vss nmos L=40e-9 W=90e-9
m1 net4 d1 vss vss nmos L=40e-9 W=90e-9
m0 out _net1 net4 vss nmos L=40e-9 W=90e-9
**m11 _net0 _net1 vdd vdd pmos L=40e-9 W=180e-9
**m10 q out vdd vdd pmos L=40e-9 W=180e-9
m9 _net1 out vdd vdd pmos L=40e-9 W=180e-9
m8 _net1 d2 vdd vdd pmos L=40e-9 W=180e-9
m7 out _net1 vdd vdd pmos L=40e-9 W=180e-9
m6 out d1 vdd vdd pmos L=40e-9 W=180e-9
**.ends Arbiter

.param clock_freq=2
.tran 10ps 4ns UIC
**.MEASURE TRAN PowEva1 INTEG I(vsupply) From=0ns TO=3.99ns
**.MEASURE TRAN outa1 TRIG V(out) VAL = 0.5 RISE = 1 TARG V(out) VAL = 0.5 RISE = 1
.END
