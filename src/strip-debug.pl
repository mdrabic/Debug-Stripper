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
# -standard exit method
#-------------------------------------------------------------------------------


#Imports 
use Getopt::Std;
use Cwd;

#Globals
my $debugTagStart = "\@DEBUG";	     #Remove Code Starting Here
my $debugTagFinish = "\@END DEBUG";  #Stop Removing Code Here
my $sourceFile;			     #Source File to strip - arg[0]
my $cleanSource;                     #Debug-Free Output file -arg[1]
my $results;	     		     #Results file holding Removed Code -arg[2] 
my $simulate;			     #Simulate - Don't remove lines
my $rootDir;			     #Directory - Batch processing 





parse_commandLine_options();
strip_code();
clean_up();






# name strip_code
# description The $sourceFile is read line by line and looks for the $debug 
#	      tags. All lines not between the debug tags are written to 
# 	      $cleanSource. A $results file is created which shows a listing of
#             code removed / not written to the $cleanSource file. 	      
# parmas: none
# return: none
sub strip_code
{
	my $debugCode = 0;      #State Variable 
	my $linesRemoved = 0;   #Number of lines Removed
	my $lineNumber = 0;     #The current line number 


	#Open the source file, create the cleaned source & results file 
	open SOURCE, '<', $sourceFile or die $!;        
	open CLEAN_SOURCE, '>', $cleanSource or die $!;
	open RESULTS, '>', $results or die "No output file specified\n";


	print "\nRemoving code between ".$debugTagStart." and ".$debugTagFinish."\n";


	#Main loop to remove debug code
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


	print RESULTS "\n\nTotal Lines Removed: ".$linesRemoved;
	print "Total Lines Removed: ".$linesRemoved."\n\n";
}




# name parse_commandLine
# description setup the environment by determining any command line options
#             or parameters that were specified. Parse all options first, then
# 	      get the files to be processed. These files should be the last two 
# 	      args in the command line. 
# parmas: none
# return: none
sub parse_commandLine_options
{	
	#Cmd Options
	my $optDir  = "d";       # root directory to process from 
	my $optVerbose = "v";    # verbose execution
	my $optHelp = "h";       # help 
	my $optSim  = "s";       # future: Simulate/dry-run
	my $optCleanSrc = "c";	 # Create cleaned source file

	my $optList = 'd:c:vh';
	my %opts;
	
	getopts( "$optList", \%opts );


	#Parse for 'help' option
	if( $opts{$optHelp} == 1 ){
		#call/display help()
		exit;
	}

	#TODO: Implement directory option 
	if( $opts{$optDir} ne ""){
	#	$rootDir = getcwd();
	} 
	else {
		$rootDir = getcwd();
	} 

	#TODO: Implement verbose mode
	if( $opts{$optVerbose} == 1 ){
		print "verbose set\n";
	}

	#Parse the source and output param 
	if( ($ARGV[0] || $ARGV[1]) =~ /\w+\.["txt""java""php""html""js"c]/ ){	
		$sourceFile = $ARGV[0];		
		$cleanSource = $ARGV[1];     
		$results = $ARGV[2]; 	
	}   
	else{
		#Incorrect file names. 
		print "Non-acceptable file type.\n";
		exit;
	}
}
	



#name clean_up
#description close all files that have been opened and exit from the program.
#params none
#return none
sub clean_up
{
	close SOURCE or die $!;
	close CLEAN_SOURCE or die $!; 
	close RESULTS or die $!;
	exit;
}

