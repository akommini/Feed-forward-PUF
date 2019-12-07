
## Script to run Monte Carlo reliablity Simulations
## Usage: Type the following in unix shell
## perl run_reliability.pl <Spice_file>


## Change the name of the output log directory in the script

$sp_file=$ARGV[0];
$v_nom=1.0;
$v_l=$v_nom - (0.1*$v_nom);
$v_l2=$v_nom - (0.05*$v_nom);
$v_h=$v_nom + (0.05*$v_nom);
$v_h2=$v_nom + (0.1*$v_nom);

$temp_l=-25;
$temp_l2=0;
$temp_nom=25;
$temp_h=50;
$temp_h2=75;


$i=1;

system "perl -pi -e 's/.param vin.*/.param vin=$v_l/' $sp_file"; 
system "perl -pi -e 's/VIH.*/VIH $v_l/' challenge_rel.vec";

print "Running Hspice VDD Sweep run = $i with $v_l\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";

$i=2;



system "perl -pi -e 's/.param vin.*/.param vin=$v_l2/' $sp_file"; 
system "perl -pi -e 's/VIH.*/VIH $v_l2/' challenge_rel.vec";

print "Running Hspice VDD Sweep run = $i with $v_l2\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";

$i=3;

system "perl -pi -e 's/.param vin.*/.param vin=$v_h/' $sp_file"; 
system "perl -pi -e 's/VIH.*/VIH $v_h/' challenge_rel.vec";

print "Running Hspice VDD Sweep run = $i with $v_h\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";


$i=4;

system "perl -pi -e 's/.param vin.*/.param vin=$v_h2/' $sp_file"; 
system "perl -pi -e 's/VIH.*/VIH $v_h2/' challenge_rel.vec";

print "Running Hspice VDD Sweep run = $i with $v_h2\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";


$i=6;

## Reset VDD back to nominal
system "perl -pi -e 's/.param vin.*/.param vin=$v_nom/' $sp_file"; 
system "perl -pi -e 's/VIH.*/VIH $v_nom/' challenge_rel.vec";


system "perl -pi -e 's/.TEMP.*/.TEMP $temp_l/' $sp_file"; 

print "Running Hspice TEMP Sweep run = $i with $temp_l\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";

$i=7;



system "perl -pi -e 's/.TEMP.*/.TEMP $temp_l2/' $sp_file"; 

print "Running Hspice TEMP Sweep run = $i with $temp_l2\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";

$i=8;

system "perl -pi -e 's/.TEMP.*/.TEMP $temp_h/' $sp_file"; 

print "Running Hspice TEMP Sweep run = $i with $temp_h\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";

$i=9;

system "perl -pi -e 's/.TEMP.*/.TEMP $temp_h2/' $sp_file"; 

print "Running Hspice TEMP Sweep run = $i with $temp_h2\n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";


$i=5;

system "perl -pi -e 's/.TEMP.*/.TEMP $temp_nom/' $sp_file"; 

print "Running Hspice Nominal reliability run = $i \n";
system "hspice -mt 4 -i $sp_file > log_files_reliability/log_monte_$i";



