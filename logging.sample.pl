#!/usr/bin/perl -w

# ------------------------------------ snip - copy to each new script BEGIN
use strict;
use Getopt::Long;		      # processing command-line parameters
use mllib::logging;

package main; 
use vars qw($getopt_loglevel $program $programname);

$program="logging.sample";
$programname = $program.".pl";
my $logfilename = $program.".log";
my $version = "1.00";
my $description = "Logging-Beispielprogramm";

GetOptions("loglevel=s" => \$getopt_loglevel);

if (not(defined($getopt_loglevel))) {
   print "$description ($programname)\n";
   print "(c) Markus Linke, 2004\n\n";
   print "Usage: \n$programname\n --loglevel=EMCDQ\n\n";
   die "You did not provide any parameters. The program ended here.\n\n";
} 

# ------------------------------------ snip - copy to each new script END

logme("open",$logfilename);
logme("D","$programname V$version started --------------------------------------------------");
logme("M","This is a MESSAGE");
logme("D","This is a DEBUG-MESSAGE");
logme("E","This is an ERROR-MESSAGE");
logme("Q","This is a SQL-QUERY-MESSAGE");
logme("C","This is a CONFIGURATION-MESSAGE");
logme("M","FATAL- and SYSTEM-MESSAGES (F/S) are always logged.");
logme("M","If the loglevel parameter contains - no messages are displayed.");
#logme("F","This is a FATAL-MESSAGE");
logme("D","$programname V$version ended   --------------------------------------------------");
logme("close");

1;

__END__
Any additional comments can go here
