** Generated for: hspiceD
** Generated on: Dec  2 16:22:29 2014
** Design library name: Project_658_copy
** Design cell name: test
** Design view name: schematic


.include '/home/akommini/658proj/nmos.inc'
.include '/home/akommini/658proj/pmos.inc'
vsupply vdd 0 1.0
vss vss 0 0
.vec '/home/akommini/658proj/GaSize_anl/test_net.vec'
.TEMP 25
.OPTION POST


** Library name: Project_658
** Cell name: Arbiter
** View name: schematic
.subckt Arbiter d1 d2 q vdd vss
m12 _net0 _net1 vss vss nmos L=40e-9 W=90e-9
m5 q out vss vss nmos L=40e-9 W=90e-9
m3 net5 d2 vss vss nmos L=40e-9 W=90e-9
m2 _net1 out net5 vss nmos L=40e-9 W=90e-9
m1 net4 d1 vss vss nmos L=40e-9 W=90e-9
m0 out _net1 net4 vss nmos L=40e-9 W=90e-9
m11 _net0 _net1 vdd vdd pmos L=40e-9 W=180e-9
m10 q out vdd vdd pmos L=40e-9 W=180e-9
m9 _net1 out vdd vdd pmos L=40e-9 W=180e-9
m8 _net1 d2 vdd vdd pmos L=40e-9 W=180e-9
m7 out _net1 vdd vdd pmos L=40e-9 W=180e-9
m6 out d1 vdd vdd pmos L=40e-9 W=180e-9
.ends Arbiter

** Library name: Project_658_copy
** Cell name: test
** View name: schematic
m27 net32 start2 vdd vdd pmos L=90e-9 W=180e-9
m18 sdb1 net32 vdd vdd pmos L=90e-9 W=180e-9
m17 sdb1 net97 vdd vdd pmos L=90e-9 W=180e-9
m16 net97 c vdd vdd pmos L=90e-9 W=180e-9
m15 net97 start1 vdd vdd pmos L=90e-9 W=180e-9
m14 net32 net019 vdd vdd pmos L=90e-9 W=180e-9
m6 net019 c vdd vdd pmos L=90e-9 W=180e-9
m5 sda1 net36 vdd vdd pmos L=90e-9 W=180e-9
m4 sda1 net96 vdd vdd pmos L=90e-9 W=180e-9
m3 net96 c vdd vdd pmos L=90e-9 W=180e-9
m2 net96 start2 vdd vdd pmos L=90e-9 W=180e-9
m1 net36 net019 vdd vdd pmos L=90e-9 W=180e-9
m0 net36 start1 vdd vdd pmos L=90e-9 W=180e-9
m26 net88 net97 vss vss nmos L=40e-9 W=90e-9
m25 sdb1 net32 net88 vss nmos L=40e-9 W=90e-9
m23 net91 start1 vss vss nmos L=40e-9 W=90e-9
m22 net97 c net91 vss nmos L=40e-9 W=90e-9
m21 net92 start2 vss vss nmos L=40e-9 W=90e-9
m20 net32 net019 net92 vss nmos L=40e-9 W=90e-9
m13 net90 net96 vss vss nmos L=40e-9 W=90e-9
m12 sda1 net36 net90 vss nmos L=40e-9 W=90e-9
m11 net019 c vss vss nmos L=40e-9 W=90e-9
m10 net93 start2 vss vss nmos L=40e-9 W=90e-9
m9 net96 c net93 vss nmos L=40e-9 W=90e-9
m8 net94 start1 vss vss nmos L=40e-9 W=90e-9
m7 net36 net019 net94 vss nmos L=40e-9 W=90e-9
xi8 sda1 sdb1 out vdd vss Arbiter
.param clock_freq=2
.tran 10ps 4ns UIC
.END
