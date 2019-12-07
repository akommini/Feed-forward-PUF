## Script to calculate reliablity or bit error rate
## Usage: Type the following in unix shell
## perl get_bit_diff.pl <log_dir> <No_of_CRPs>


$log_dir=$ARGV[0];
$no_of_CRPs=$ARGV[1];

for($i=1;$i<=9;$i++) {
	open(FILE,"$log_dir/monte_response_$i");
	@response=<FILE>;
	chomp(@response);
	for($j=0;$j<$no_of_CRPs;$j++) {
	$monte[$i][$j]=$response[$j];
	}
	close(FILE);
}


for($i=1;$i<=9;$i++) {
	$ber[$i]=0;
}


for($i=1;$i<=9;$i++) {
	for($j=0;$j<$no_of_CRPs;$j++) {
		if ($monte[5][$j] != $monte[$i][$j]) {
		$ber[$i]++;
		}
	}
	
	
}

foreach $bit (@ber) {
print "$bit \n";
}





