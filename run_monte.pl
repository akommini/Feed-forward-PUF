
## Script to run Monte Carlo Simulations
## Usage: Type the following in unix shell
## perl run_monte.pl

## Change the name of the spice file and your output log directory in the script

for ($i=1;$i<=40;$i++) {
system "perl -pi -e 's/monte=list.*/monte=list($i)/g' PUF_LFSR_64_flat.sp"; 
print "Running Hspice MonteCarlo Run = $i \n";
system "hspice -mt 4 -i PUF_LFSR_64_flat.sp > log_files_uniqueness/log_monte_$i";
#system "rm -rf PUF_64.tr0*";
}
