## Script to extract responses from Monte Carlo Simulation log files
## Usage: Type the following in unix shell
## perl collect_responses.pl <log_dir> <vdd_voltage>

## Command line arguments for log file directory and supply voltage
$log_dir=$ARGV[0];
$vdd=$ARGV[1];


## Extract response for each of the 40 monte runs
for($k=1;$k<=40;$k++) {
	open(FILE,"$log_dir/log_monte_$k");
	open(OUT,">$log_dir/monte_response_$k");
	$resp=1;

## find first line of responses in Hspice log file
	until($a =~ /response/){
		$a=<FILE>;
	}

	$i=1;

## FIRST LINE TO START SAMPLING - TO BE CHANGED BY USER
	$l2p=200;		
	$l2p++;
	$a=<FILE>;

## TILL LAST LINE
	until($a =~ /y/) {
		@array=split(/\s+/,$a);
		#$num=int($array[2]);

## CHECK TO SEE IF RESPONSE AND RESPONSE_BAR ARE OPPOSITE POLARITY
## AND IF THEY ARE GREATER OR LESSER THAN VDD/2
		if (($array[2] > ($vdd / 2)) && ($array[3] < ($vdd/2)) ) {
			$num=1;
		} elsif (($array[2] < ($vdd / 2)) && ($array[3] > ($vdd/2)) ) {
			$num=0;
		} else {
			$num="X";
		}
                 

		#if ($i == $l2p && $i < 20000) {
		if ($i == $l2p && $resp <= 1000) {
		if ($num eq "X") {
			print "Incorrect response obtained , Check sampling point\n";
		}
		print OUT "$num\n";

## INCREMENT BY PERIOD / FREQUENCY OF INPUT SIGNAL - TO BE CHANGED BY USER
		$l2p = $l2p + 400; 	
		$resp++;
	}
	$a=<FILE>;
	$i++;
	}
	close(FILE);
	close(OUT);
}
