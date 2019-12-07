## Script to calculate uniqueness ( hamming distance )
## Usage: Type the following in unix shell
## perl calc_hamming_dist_all.pl <log_directory> <No of CRPs> <No of PUFs>

$log_dir=$ARGV[0];
$bit_len=$ARGV[1];
$no_of_pufs=$ARGV[2];

print "$log_dir $bit_len $no_of_pufs\n";
sub hm_dist ($$) {
$dist=0;
#print "$_[0] and $_[1] \n";
for ($k=0;$k<$bit_len;$k++) {
	$a=substr($_[0],$k,1);
        $b=substr($_[1],$k,1); 
	if ($a ne $b) {
	$dist++;
	}
}
	return $dist;
}

#$log_dir=$ARGV[0];

for($i=1;$i<=$no_of_pufs;$i++) {
	open(FILE,"$log_dir/monte_response_$i");
	@response=<FILE>;
	chomp(@response);
	$start=0;
	$len=$start + $bit_len -1;
	$monte[$i][0]=join("",@response[$start..$len]);
	close(FILE);
}



for($i=0;$i<=$bit_len;$i++) {
	$hamming_dist{$i}=0;
}

#while (($wt,$cnt) = each(%hamming_dist)) {
#	print "Distance,Count is : $wt,$cnt \n";
#}

#print "*******************************************\n";
#print "*******************************************\n";
#print "*******************************************\n";

for($i=1;$i<=$no_of_pufs;$i++) {
	for($j=$i+1;$j<=$no_of_pufs;$j++) {
	$dist_0=hm_dist($monte[$i][0],$monte[$j][0]);
#	print "4 distances are : $dist_0 $dist_1 $dist_2 $dist_3";
	$hamming_dist{$dist_0}++;
	}
}

$num=0;
$sum=0;

while (($wt,$cnt) = each(%hamming_dist)) {
	print "$wt,$cnt\n";
	$num+=$cnt;
	$sum=$sum + ($cnt*$wt);
}


$hamm_dist=$sum/$num;
$hamm_per=($hamm_dist/$bit_len)*100;


$nums=0;
$sumsqr=0;

while (($wt,$cnt) = each(%hamming_dist)) {
	#print "$wt,$cnt\n";
	$nums+=$cnt;
        $wt_m_mean= $wt - $hamm_dist;
        $diffsqr= $wt_m_mean*$wt_m_mean;
	$sumsqr=$sumsqr + ($diffsqr*$cnt);
}

$var=$sumsqr/$nums;
$sd=sqrt($var);

print "The mean hamming distance for $num comparisons is  : $hamm_dist\n";
print "The relative hamming distance is : $hamm_per\n";
print "The standard deviation for $nums comparisons is : $sd\n";


