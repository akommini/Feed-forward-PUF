
.GLOBAL vss! vdd!

.include '/home/akommini/658proj/NMOS32LP.inc'
.include '/home/akommini/658proj/PMOS32LP.inc'
vsupply vdd! 0 0.4
Vsupply2 vdd1 0 0.4
vss vss! 0 0
.vec 'Test90_90.vec'
vclock clk 0 PWL (0 0 3.49n 0 3.5n 1.1 3.9n 1.1)

.TEMP 25
.OPTION POST


.subckt Arbiter d1 d2 out vdd vss
**m12 _net0 _net1 vss vss NMOS_VTL L=40e-9 W=1080e-9
**m5 q out vss vss NMOS_VTL L=40e-9 W=1080e-9
m3 net5 d2 vss vss NMOS_VTL L=40e-9 W=1080e-9
m2 _net1 out net5 vss NMOS_VTL L=40e-9 W=1080e-9
m1 net4 d1 vss vss NMOS_VTL L=40e-9 W=1080e-9
m0 out _net1 net4 vss NMOS_VTL L=40e-9 W=1080e-9
**m11 _net0 _net1 vdd vdd PMOS_VTL L=40e-9 W=1080e-9
**m10 q out vdd vdd PMOS_VTL L=40e-9 W=1080e-9
m9 _net1 out vdd vdd PMOS_VTL L=40e-9 W=1080e-9
m8 _net1 d2 vdd vdd PMOS_VTL L=40e-9 W=1080e-9
m7 out _net1 vdd vdd PMOS_VTL L=40e-9 W=1080e-9
m6 out d1 vdd vdd PMOS_VTL L=40e-9 W=1080e-9
.ends Arbiterf


**upper mux
m6 net16 a vss! vss! NMOS_VTL L=40e-9 W=1080e-9 DELVTO =0.022273
m5 n1 s net16 vss! NMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.169476
m4 n1 a vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.059185
m3 n1 s vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.055466
m1 invo s vss! vss! NMOS_VTL L=40e-9 W=540e-9  DELVTO =0.108195
m2 invo s vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.021479
m7 net17 b vss! vss! NMOS_VTL L=40e-9 W=1080e-9 DELVTO =0.082253
m8 n2 invo net17 vss! NMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.009936
m9 n2 b vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.041156
m10 n2 invo vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.010564
m11 net18 n1 vss! vss! NMOS_VTL L=40e-9 W=1080e-9 DELVTO =-0.019940
m12 n3 n2 net18 vss! NMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.069720
m13 n3 n2 vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.000065
m14 n3 n1 vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.008020
m15 net19 b vss! vss! NMOS_VTL L=40e-9 W=1080e-9 DELVTO =0.003262
m16 n4 s net19 vss! NMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.001842
m17 n4 b vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.015090
m18 n4 s vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.040399
m21 net20 a vss! vss! NMOS_VTL L=40e-9 W=1080e-9 DELVTO =0.052206
m22 n5 invo net20 vss! NMOS_VTL L=40e-9 W=1080e-9  DELVTO =0.059253
m23 n5 a vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.001519
m24 n5 invo vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.035739
m25 net21 n4 vss! vss! NMOS_VTL L=40e-9 W=1080e-9 DELVTO =0.112387
m26 n6 n5 net21 vss! NMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.011769
m27 n6 n5 vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.029592
m28 n6 n4 vdd! vdd! PMOS_VTL L=40e-9 W=1080e-9  DELVTO =-0.053001
X1 n3 n6 va vdd1 vss! Arbiter

.param clock_freq=2
.tran 10ps 50ns UIC
.MEASURE TRAN tdlayS1a1 TRIG V(a) VAL = 0.175 RISE = 1 TD=0.5ns TARG V(s) VAL = 0.175 RISE = 1
.MEASURE TRAN tdlayS1a4 TRIG V(va) VAL = 0.175 RISE = 1 TD=0.5ns TARG V(s) VAL = 0.175 RISE = 1

.MEASURE TRAN tdlayS1a2 TRIG V(a) VAL = 0.175 RISE = 1 TD=0.5ns TARG V(b) VAL = 0.175 RISE = 1
.MEASURE TRAN tdlayS1a3 TRIG V(n3) VAL = 0.2 RISE = 1 TD=0.5ns TARG V(n6) VAL = 0.2 RISE = 1
.PRINT TRAN tdlayS1a1 
.END
