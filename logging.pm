package mllib::logging;

# (c) Markus Linke, 2004
# This module creates a logfile 

use strict;
use vars qw(@ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $VERSION);

use base qw(Exporter);
$VERSION = 1.00;
@EXPORT=qw(&logme &gettimestamp);

1;

sub logme{

# F = Fatal
# E = Error
# M = Message
# D = Debug
# C = Configuration
# Q = SQL


   my $severity = $_[0];
   
   if ($severity eq "open") {open LOGFILE,">>$_[1]" or die "*** Fatal Error: Logfile cannot be opened.";}
   elsif ($severity eq "close") {close LOGFILE or die "*** Fatal Error: Logfile cannot be closed.";}
   
   elsif ($main::getopt_loglevel =~ m/$severity/) {
      my $message = $_[1];
      my $timestamp = &gettimestamp();
      my $line = "$timestamp [$main::programname] <$severity> $message\n";
      if (not $main::getopt_loglevel =~ m/-/) {print $line;}
      print LOGFILE $line;
   }
   
   if (($severity eq "E") || ($severity eq "F")) {$main::error_occured++;}
   
   if ($severity eq "F") {  
   close LOGFILE;
   die "\n*** Fatal Error: $_[1]\n\n";
   }
}

sub gettimestamp {
   my $format = $_[0];
   my ($sec,$min,$hour,$mday,$mon,$year) = localtime;
   $year=$year+1900;
   $mon=$mon+1;
   if ($mon<10) {$mon = "0".$mon;}
   if ($mday<10) {$mday = "0".$mday;}
   if ($hour<10) {$hour = "0".$hour;}
   if ($min<10) {$min = "0".$min;}
   if ($sec<10) {$sec = "0".$sec;}
   if (defined($format)) {
      if ($format eq "filename") {
         return "$year"."$mon"."$mday"."$hour"."$min"."$sec";
      }
   } else {
      return "$year-$mon-$mday $hour:$min:$sec";
   }
}
