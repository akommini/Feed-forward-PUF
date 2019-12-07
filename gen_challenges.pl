## Script to generate challenge vector file with random challenges

open(OUT_FILE,">/home/cad/PUF_ENERGY/Arbiter_PUF/scripts/challenge_rel.vec");

@radix="RADIX ";@vname="VNAME ";@IO="IO ";
	
	push(@vname,"c[64:1]");

for($i=16;$i>=1;$i--) {
	push(@radix,"4");
	push(@IO,"I");
}

#	push(@radix,"1");
#	push(@vname,"in");
#	push(@IO,"I");

print "The final radix is : @radix\n";
print "The final vname is : @vname\n";
print "The final IO is : @IO\n";

print OUT_FILE "@radix\n";
print OUT_FILE "@vname\n";
print OUT_FILE "@IO\n";
print OUT_FILE "TUNIT ns\n";
print OUT_FILE "PERIOD 4\n";
print OUT_FILE "TRISE 0.01\n";
print OUT_FILE "TFALL 0.01\n";
print OUT_FILE "VIH 1.1\n";
print OUT_FILE "VIL 0\n";

#my $range=18446744073709551616;
my $range=4294967296;

for ($i=0;$i<1000;$i++) {

	$rand_1 = int(rand($range));
	$rand_2 = int(rand($range));
	$random_number=$rand_1*$rand_2;
	print "$random_number\n";
	$rand_hex=sprintf("%016x",$random_number);
	print "$rand_hex\n ";
	$challenge[$i]=$rand_hex;
}


foreach $j (@challenge) {

print OUT_FILE "$j\n";

}

close $OUT_FILE;
