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


#Notes & TODO:
# -use strict vars
# -Move ARGV stuff to parse_commandLine
# -Create 
#-------------------------------------------------------------------------------


#Imported Modules 
use Getopt::Std;




my $debugTagStart = "\@DEBUG";	     #Remove Code Starting Here
my $debugTagFinish = "\@END DEBUG";  #Stop Removing Code Here
my $cleanSource = $ARGV[1];          #Debug-Free Output file
my $results = $ARGV[2]; 	     #Listing of Removed Code 
my $debugCode = 0; 	             #State Variable
my $linesRemoved = 0;                #Number of lines Removed
my $lineNumber = 0;                  #The current line number 

open SOURCE, '<', $ARGV[0] or die $!;#Source code file
open CLEAN_SOURCE, '>', $cleanSource or die $!;
open RESULTS, '>', $results or die "No output file specified\n";


print "\nRemoving code between ".$debugTagStart." and ".$debugTagFinish."\n";


while (my $line = <SOURCE>){
	
	$lineNumber++;
	
	if($line =~ /$debugTagStart/){
		$debugCode = 1;	
		print RESULTS "Removed From: ".$ARGV[0]."\n";	
		print RESULTS "---------------------------------------\n";
	}
	elsif($line =~ /$debugTagFinish/){
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



#-------------------------------------------------------------------------------

# name parse_commandLine
# description setup the environment by determining any command line options
#             or parameters that were specified. 
# parmas: none
# return: none
sub parse_commandLine_options
{
	#Cmd Options
	my $optDir = 'd';    # root directory to start processing
	my $optVerbose = 'v'; # verbose execution
	my $optHelp = 'h';    # help 
	my $optList = "d:vh";

 	
	getopt($optList,\%cmdOptions);


	#Parse for 'help' option
	if( $cmdOptions{$optHelp}  == 1  ){
		#call/display help()
		return;
	}

	#Find if a root prjoect directory specified
	if( $cmdOptions{$optDir} eq ("" || " ")){
		#display option value error
		return
	} 
	else {
		#parse root directory
	} 

	#Parse for Verbose mode
	if( $cmdOptions{$optVerbose} == 1 ){
		#set output mode
	}
}
	

	
















