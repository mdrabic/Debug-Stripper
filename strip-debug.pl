#!/usr/bin/perl

# Title Strip-Debug
# Description Creates a new file that is removes code between the specified debug 
#	     tags. The first param is the name of the file to create which has 
#  	     the debug code removed. The second param is the name you want to 
#	     give the results file that shows a listing of the lines of code 
#            removed. 
# 
# Revision v1
# Author MDrabic

# History
# 8/12/2011 - Inital Version - v1


#-------------------------------------------------------------------------------
# Extras:
#*iteractive mode? 
#*Changeable Tags?
#-------------------------------------------------------------------------------




my $debugStart = "\@DEBUG";	     #Remove Code Starting Here
my $debugFinish = "\@END DEBUG";     #Stop Removing Code Here
my $cleanSource = @ARGV[1];          #Debug-Free Output file
my $results = @ARGV[2]; 	     #Listing of Removed Code 
my $debugCode = 0; 	             #State Variable
my $linesRemoved = 0;                #Number of lines Removed
my $lineNumber = 0;                  #The current line number 

open SOURCE, '<', @ARGV[0] or die $!;#Source code file
open CLEAN_SOURCE, '>', $cleanSource or die $!;
open RESULTS, '>', $results or die "No output file specified\n";


print "\nRemoving code between ".$debugStart." and ".$debugFinish."\n";


while (my $line = <SOURCE>){
	
	$lineNumber++;
	
	if($line =~ /$debugStart/){
		$debugCode = 1;	
		print RESULTS "Removed From: ".@ARGV[0]."\n";	
		print RESULTS "---------------------------------------\n";
	}
	elsif($line =~ /$debugFinish/){
		$debugCode = 0;		
		print RESULTS "\n\n";
	}
	elsif($debugCode == 0){
		print CLEAN_SOURCE $line;		
	}
	else{
		$linesRemoved++;
		print RESULTS "line: ".$lineNumber."     ".$line;
	}
}	


print "Total Lines Removed: ".$linesRemoved."\n\n";


close SOURCE or die $!;
close CLEAN_SOURCE or die $!; 
close RESULTS or die $!;


exit;

 
