#use strict;
#perl filename.pl #num_of_chips #challenge_id #start_chip_id
use warnings;
use POSIX qw(ceil);
#my @inputPatterns=("01 01 01");

#my $startDeviceId=$ARGV[0]; ### for number of chips
my $startDeviceId=$ARGV[0]; 
my $numOfIterations=1;
my $currIteration;
#my $numOfChips=$ARGV[1];
my $numOfChips=1;
#my $numOfChallenge=128;
my $numOfCycles=1;
#my $numOfInputs=25000;
my $numOfColumns=10;
my $numOfRows=$numOfCycles;
my $numOfstages=1;
my $deviceId;
my @devArray;
my @chip_process;
my $voltage = $ARGV[3];
my $half_val = ($voltage/2);
#my $i_start = $ARGV[2];

#system("sed '\$d' arbPUF128.sp > arbPUF128.netlist");

open proCessFile,"</home/akommini/658proj/delvto_new1.txt" or die "cant open";
@tmp_process_data = <proCessFile>;

#open lengthFile,"</home/Raghavan/research/side_channel_PUF/feedForwardPufFProject/length.txt" or die "cant open";
#@length_process_data = <lengthFile>;

my $n_process_data = $#tmp_process_data;
for($j=0;$j<=$n_process_data;$j++){
	@{$devArray{$j}} = split('\s',$tmp_process_data[$j]);		##### array to store process variations data
#	@{$lenArray{$j}} = split('\s',$length_process_data[$j]);
}
close proCessFile;
#close lengthFile;
#open challengeFile,"</home/akommini/658proj/challenges_arb128.out" or die "cant open";
#@challenge = <challengeFile>;
#my $n_challenges = $#challenges;
#
system("mkdir Results1");
system("mkdir Results1/Reliable_arbpuf");
system("mkdir Netlist1");
system("mkdir Netlist1/arbpuf");
system("mkdir Netlist1/arbpuf/voltage$voltage");
#system("mkdir /data/Raghavan/Results/Reliable_arbpuf/unique");
	
for($deviceId=$startDeviceId;$deviceId<($numOfChips+$startDeviceId);$deviceId++)
	{
	system("mkdir Results1/Reliable_arbpuf/Chip$deviceId");	
	system("mkdir Netlist1/arbpuf/voltage$voltage/Chip$deviceId");

	for($currIteration=1;$currIteration<=$numOfIterations;$currIteration++)
	{
		system("mkdir Results1/Reliable_arbpuf/Chip$deviceId/run$currIteration");
		system("mkdir Results1/Reliable_arbpuf/Chip$deviceId/run$currIteration/voltage$voltage");
		system("mkdir Netlist1/arbpuf/voltage$voltage/Chip$deviceId/run$currIteration");
		my @bigResultArray;
		my $bigrowPointer=1;
		my $error=0;
		#@chip_process = @{$devArray{$deviceId}};
		#@gate_length = @{$lenArray{$deviceId}};
		my $i=1;
		my $j;
		my $period=4;
		#### this iteration is for number of challenges for which response is collected
		#for(my $iteration=1;$iteration<=$numOfInputs;$iteration++)
		#while($iteration<=$numOfInputs && $error==0)
		
		$startIteration = $ARGV[1];
		$endIteration = $ARGV[2];

		#$startIteration = (($i_start-1)*$numOfInputs)+1;
		#$endIteration = ($i_start*$numOfInputs);

		for($iteration=$startIteration;$iteration<=$endIteration;$iteration++)
			{
				$i=1;
				$j=0;
			## generate the Netlist with the corresponding measurement statements
			#$tmpStr = "Netlist/arbpuf/voltage$voltage/Chip";
			#$tmpStr = $tmpStr.$deviceId."/"."run".$currIteration."/"."generated_Challenge".$iteration.".netlist";
			open netlistFile,">","Netlist1/arbpuf/voltage$voltage/Chip$deviceId/run$currIteration/generated_Challenge$iteration.sp";
			#open inputNetlist, "<", "iMDPL_and.netlist";
			open inputNetlist, "<","NAND90_90.sp";
			#@input_netlist = <inputNetlist>;
			#my $n_line_netlist = $#input_netlist;

			while (my $line = <inputNetlist>)
			{
				
=head
                         		if($i==8){
					#print netlistFile ".OPTION POST\n";
					print netlistFile ".include '/home/akommini/658proj/NMOS32LP.inc'\n";
					print netlistFile ".include '/home/akommini/658proj/PMOS32LP.inc'\n";
					print netlistFile "vsupply vdd! 0 $voltage\n";
					print netlistFile "vss vss! 0 0\n";	
					print netlistFile ".vec 'Test90_90.vec'\n";
					print netlistFile "vclock clk 0 PWL (0 0 3.49n 0 3.5n 1.1 3.9n 1.1)\n";
				}
=cut
	
				if($i>=46 && $i<72)
				{

					if($line =~ /dl/)
                                        {
                                                #$line =~ s/dl/$gate_length[$j]e-9/;
                                                $line =~ s/dl/0e-9/;
                                        }

					chomp($line);
                                        @chip_process = @{$devArray{$iteration}};
					$line= $line . " DELVTO =" .$chip_process[$j]. "\n";
					$j=$j+1;
				}
				
				if($line =~ /.OPTION/){
					$line = $line."+ POST=2\n+ PROBE";
					print netlistFile $line;
					print netlistFile "\n";
				}
				elsif($line =~ /.TEMP/){
					$line = ".TEMP 25";
					print netlistFile $line;
					print netlistFile "\n";
				}
				elsif($line =~ /PSF/){
					$line ="";
					print netlistFile $line;
				}
				elsif($line =~ /PARHIER/){
					$line ="";
					print netlistFile $line;
				}
				elsif($line =~ /ARTIST/){
					$line ="";
					print netlistFile $line;
				}
				elsif($line =~ /INGOLD/){
					$line ="";
					print netlistFile $line;
				}
				else{
					print netlistFile $line;
				}
				$i=$i+1;
			}

			print netlistFile  ".param clock_freq=",$period/2,"\n";
			#print netlistFile " .OPTION POST=2 \n  Vsupply vdd! 0 1.1\n  vss vss! 0 0\n  .VEC '68stage2FFPUF.vec'\n  ";
			my $currDelay;

			for($i = 1; $i<= $numOfCycles; $i++)
			{
				print netlistFile ".tran 10ps ",$period*($numOfCycles)*5 ,"ns UIC\n";
				#print netlistFile ".MEASURE TRAN tdlay",$i, " TRIG V(s18a) VAL = 0.5 RISE = ", $i," TARG V(s18b) VAL = 0.5 RISE = ",$i,"\n";
				#$currDelay=(($i-1)*$period)+($period/2);
				$currDelay=0.5;
				for(my $tmpStage=1;$tmpStage<=$numOfstages;$tmpStage++)
				{			
					print netlistFile ".MEASURE TRAN tdlayS",$tmpStage,"a",$i, " TRIG V(n3) VAL = $half_val RISE = 1 TD=",$currDelay ,"ns TARG V(n6) VAL = $half_val RISE = 1\n";
				}
				#print netlistFile ".MEASURE TRAN PowEva",$i, " INTEG I(vsupply) From=",$currDelay+0.02, "ns TO=",$period-0.01,"ns\n";
	#			print netlistFile ".MEASURE TRAN PowEva1Half",$i, " INTEG I(vsupply) From=",$currDelay-0.1, "ns TO=",$currDelay+0.25,"ns\n";
				#print netlistFile ".MEASURE TRAN PowEva1Half",$i, " INTEG I(vsupply) From=",$currDelay+0.02, "ns TO=",$currDelay+0.7,"ns\n";
				#print netlistFile ".MEASURE TRAN PowEva2Half",$i, " INTEG I(vsupply) From=",$currDelay+0.7, "ns TO=",$currDelay+1.39,"ns\n";
				#print netlistFile ".MEASURE TRAN PowEva3Half",$i, " INTEG I(vsupply) From=",$currDelay+2.75, "ns TO=",$currDelay+3.25,"ns\n";
				#$currDelay=($i*$period)-0.009;
				#print netlistFile ".MEASURE TRAN ff1a",$i, " AVG V(ff1a) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN ff2a",$i, " AVG V(ff2a) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN ff3a",$i, " AVG V(ff3a) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN ff4a",$i, " AVG V(ff4a) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN ff5a",$i, " AVG V(ff5a) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN ff6a",$i, " AVG V(ff6a) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN ff7a",$i, " AVG V(ff7a) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN ya",$i, " AVG V(ya) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".MEASURE TRAN outa",$i, " AVG V(out) FROM=", $currDelay,"ns TO=", $currDelay+0.0001,"ns\n";
				#print netlistFile ".IC I(vsupply)=0 V(start1)=0 V(start2)=0 V(ya)=0 V(out)=0\n";
				print netlistFile ".PRINT TRAN tdlayS1a1 \n";	
			}	

			#print netlistFile ".IC V(vsupply)=0 V(ya)=0 V(out)=0\n";
			#print netlistFile ".tran 0.00001ps ",$period*($numOfCycles+2) ,"ns \n";
			#print netlistFile ".tran 0.001ps ",$period*($numOfCycles+2) ,"ns \n";
			print netlistFile ".END\n";
=head
			open myVecfile, ">", "Netlist/arbpuf/voltage$voltage/Chip$deviceId/run$currIteration/68stage2FFPUF$iteration.vec";

			#my @inputPatterns=("00110 01010 00101 0","00100 00010 00010 1", "01110 01001 00010 0", "10010 01001 00010 0","00101 00100 00100 0","00110 10010 10000 0", "00001 10000 00100 1", "11000 01110 00001 0","10010 01110 10101 0","10100 01011 01110 1");
			my @inputPatterns;
			#for($i=1;$i<=$numOfCycles;$i++)
			#{
				#my $tmpString="";
				#for($j=1;$j<=$numOfChallenge;$j++)
				#{
				#	$tmpString=$tmpString . int rand(2);
				#}
				#$inputPatterns_zero = "0000000000000000000000000000000000000000000000000000000000000";
				#$inputPatterns=$challenge[$iteration];
			#}

			#print myVecfile ";Input file for an 18 stage MUX Puf with 2 feed forwards\n RADIX";
			print myVecfile "RADIX 11";	
			for($i=1;$i<=$numOfChallenge;$i++)
			{
				print myVecfile "1";
			}
			print myVecfile "\nVNAME start1 start2 ";
			for($i=1;$i<=$numOfChallenge;$i++)
			{
				print myVecfile "chal",$i," ";
			}
			print myVecfile "\nIO II";
			for($i=1;$i<=$numOfChallenge;$i++)
			{
				print myVecfile "I";
			}
			print myVecfile "\nTUNIT ns \nVIH 1.1 \n";
			$period_vec_file = ($period/2);	
			print myVecfile "VIL 0.0\nTRISE 0.01 \nTFALL 0.01 \nPERIOD $period_vec_file \n\n";	
			#print myVecfile "VIL 0.0\nTRISE 0.01 \nTFALL 0.01 \n\n";
			

			for($i = 1; $i <= $numOfCycles; $i++) {
				#for($j=1; $j<=$numOfChallenge; $j++)
				#{
				#$tstvec[$j] = join($tstvec[$j]," ",shift($challenge[$i]));
 				#}
				print myVecfile "0 0 1 1 0 0 1 1 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 1 0 1 0 1 1 0 0 0 1 0 0 1 0 0 1 1 0 1 0 0 0 0 1 1 1 0 0 0 1 1 1 1 1 0 1 0 0 0 0 1 1 1 0 1 0 1 1 0 1 0 0 1 0 0 0 1 0 0 0 1 1 1 1 0 0 1 1 0 1 0 1 1 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 1 1 1 0 1 0 0 0 1 0 0 1 0 0 0 1 0 1 1","\n";
				print myVecfile "1 1 1 1 0 0 1 1 0 0 1 0 0 0 0tdlayS1a1 0 1 0 0 0 0 0 1 1 0 1 0 1 1 0 0 0 1 0 0 1 0 0 1 1 0 1 0 0 0 0 1 1 1 0 0 0 1 1 1 1 1 0 1 0 0 0 0 1 1 1 0 1 0 1 1 0 1 0 0 1 0 0 0 1 0 0 0 1 1 1 1 0 0 1 1 0 1 0 1 1 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 1 1 1 0 1 0 0 0 1 0 0 1 0 0 0 1 0 1 1","\n";
				#print myVecfile "0 0",join($challenge[$numOfCycles]," "),"\n";
				#print myVecfile "1 1",join($challenge[$numOfCycles]," "),"\n";
				#print myVecfile "0 00", $inputPatterns;
				#print myVecfile "0.5 11", $inputPatterns;
			}

=cut			
			#$tmpStr = "Netlist/arbpuf/voltage$voltage/Chip";
                        $tmpStr = "Netlist1/arbpuf/voltage$voltage/Chip$deviceId/run$currIteration/generated_Challenge$iteration.sp";
			$tmpString = "hspice -mt 4 -i $tmpStr -o Results1/Reliable_arbpuf/Chip";
			$tmpString = $tmpString.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration;
			system($tmpString);
			#system("rm -rf $tmpStr");
			$tmpStr1 = "Results1/Reliable_arbpuf/Chip";
			$tmpStr1 = $tmpStr1.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration.".tr0";
			system("rm -rf $tmpStr1");

			$tmpStr1 = "Results1/Reliable_arbpuf/Chip";
                        $tmpStr1 = $tmpStr1.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration.".err0";
			system("rm -rf $tmpStr1");

			$tmpStr1 = "Results1/Reliable_arbpuf/Chip";
                        $tmpStr1 = $tmpStr1.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration.".pa0";
                        system("rm -rf $tmpStr1");

			$tmpStr1 = "Results1/Reliable_arbpuf/Chip";
                        $tmpStr1 = $tmpStr1.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration.".ic0";
                        system("rm -rf $tmpStr1");

			$tmpStr1 = "Results1/Reliable_arbpuf/Chip";
                        $tmpStr1 = $tmpStr1.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration.".st0";
                        system("rm -rf $tmpStr1");
			$tmpStr1 = "Results1/Reliable_arbpuf/Chip";
                        $tmpStr1 = $tmpStr1.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration.".";
                        system("rm -rf $tmpStr1");

			$tmpStr1 = "Results1/Reliable_arbpuf/Chip";
                        $tmpStr1 = $tmpStr1.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge".$iteration.".mt0";
			$tmpStrNew = "Results1/Reliable_arbpuf/Chip";
                        $tmpStr2 = $tmpStrNew.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenge_temp.txt";
			system("sed '1,3d' $tmpStr1 >> $tmpStr2");
			system("rm -rf $tmpStr1");
                        #$tmpSting=$tmpStrNew.$deviceId."/"."run".$currIteration."/"."voltage".$ARGV[3]."/"."result_Challenges.txt";
			#system("cat $tmpStr2 >> $tmpString");
			
			#open resultFile2, ">>", $tmpSting or die "cant open";
			#@result_process_data = <resultFile2>;
			#open delayFile, "<", $tmpStr2 or die "cant open";;
			#@delay_process_data = <delayFile>;
			#system($tmpSting);
			#$tmpSting="Results/Reliable_arbpuf/arbpuf/Chip";
			#$tmpSting = $tmpSting.$deviceId."/"."run".$currIteration."/"."run1".".csv";
			
			#print resultFile2 "Challenge; tdlayS18a; tdlayS1a; tdlayS2a; tdlayS3a; tdlayS4a; tdlayS5a; tdlayS6a; Energy; ya; ff1a; error?";
			#for($i = 1; $i <= $numOfCycles; $i++)
			#{
			        #while(my $line = <delayfile>){
				#print resultFile2 $line;
				#print resultFile2 "\n";
				#}
			#}
			
			#close delayFile;
			#close inputNetlist;
			close netlistFile;
			#close myVecfile;
			#close resultFile2;
			
		}
		
	}
}

