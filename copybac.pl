#!/usr/bin/perl
# copybac
#   Copyright (C) 2013-2014 Matthew Blau
#    This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by 
#    the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, 
#    Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
use warnings;
use strict;
use File::Rsync;
use Cwd;
use Config::Simple;
if (!-e 'copybac.cfg'){
print "Let's go through some beginning configuration.\n";
}else{
sub create_cfg{
        if (-e 'copybac.cfg'){
                print "loading saved configuration file\n";
                access_config();
        }else{
                print "To begin, enter the local directory you want to sync\n";
                my $src = <STDIN>;
                chomp($src);
                print "what is your username and directory you want synced?\n";
                my $username =<STDIN>;
                chomp($username);
                my $cfg = new Config::Simple(syntax => 'ini');
                $cfg->param("source.directory", "$src"),
                $cfg->param("rsync.user", "$username");
                $cfg->write("copybac.cfg");
                }
        }
};
 
create_cfg();
# access the previously created configuration file
sub access_config{
        my $dir = cwd();
        my $cfg = new Config::Simple();
        $cfg->read('copybac.cfg');
        my $src = $cfg->param("source.directory"),
        my $dest = $cfg->param("rsync.user");
        my $obj = File::Rsync->new(
        { archive => 1,
           compress => 1,
           rsh => '/usr/bin/ssh -i $dir/.ssh/id_rsa',
           'rsync-path' => '/usr/bin/rsync'
        }
        );      
         $obj->exec(
                { src => $src,
                   dest => $dest
                }
                ) or warn "rsync failed\n";
};


