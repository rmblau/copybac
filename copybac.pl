#!/usr/bin/perl
# copybac
#   Copyright (C) 2013  Matthew Blau

#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use strict;
use warnings;
my $answer;
sub rsync{
print "what directory do you want synced?\n";
my $dir = <STDIN>;
chomp($dir);
print "Please supply your username and address you want it backed up to  in the following format: \"user \@address:/directory/name\"\n";
my $des = <STDIN>;
chomp($des);
system('rsync',  '-avz',  $dir, $des);
}

print "Do you want to configure a static directory and server?\n";
	$answer =<STDIN>;
	chomp($answer);
	if ($answer eq "yes"){
		 print "enter directory for permanent use:\n";
my $loc = <STDIN>;
chomp($loc);
print "enter server username and address in the following format: \user\@address:/directory/name\n";
my $server = <STDIN>;
chomp($server);
open my $fh, (">>config.txt") or die "Cannot create file\n";
print $fh "$loc\n";
print $fh "$server\n";
close($fh);
open $fh, "<config.txt";
my $first = <$fh>;
my $second =<$fh>;
chomp($first, $second);
print "saving config\n";
system('rsync',  '-avz',  $first, $second);
sleep(3);
print "Transfer complete!\n";
exit;
}
	  if ($answer eq "no"){
		&rsync;
	}else{
		print "I'm sorry, I don't recognize your response\n";
	}


