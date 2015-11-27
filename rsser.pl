#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: update.pl
#
#        USAGE: ./update.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 2015/11/22  3:53:24
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use MyPlace::String::Utils qw/strtime/;


my $TOPDIR = $0;
$TOPDIR =~ s/\/[^\/]+$//;
$TOPDIR =~ s/\/+$//;
if(!$TOPDIR) {
	$TOPDIR = "";
}
elsif($TOPDIR eq '.') {
	$TOPDIR = '';
}
else {
	$TOPDIR = $TOPDIR . '/';
}

my %TIME;
$TIME{CIRCLE} = shift(@ARGV) || (1 * 24 * 60 * 60);
$TIME{START} = time;


if(@ARGV) {
	$TIME{END} = time;
	$TIME{LEFT} = shift(@ARGV);
	goto CIRCLE_NEXT;
}

CIRCLE_START:
print STDERR "\n",strtime(),": Circle start\n";
system($TOPDIR . "bin/update.pl",$TOPDIR,@ARGV);


$TIME{END} = time;
$TIME{LEFT} = $TIME{CIRCLE} - ($TIME{END} - $TIME{START});


CIRCLE_NEXT:
print STDERR "\n",strtime(),
	":  Next update in $TIME{LEFT} seconds, ",
	strtime($TIME{END} + $TIME{LEFT}),"\n";
sleep $TIME{LEFT};
$TIME{START} = time;
goto CIRCLE_START;



exit 0;

