#!/usr/bin/perl
 
use warnings;
use strict;
use Time::HiRes qw(gettimeofday);
 
my $start_time = gettimeofday;
 
my $N = 10000000;
my @a;
 
sub pushDown {
    my ($pos, $N) = @_;
    while (2 * $pos + 1 < $N) {
        my $j = 2 * $pos + 1;
        if ($j + 1 < $N && $a[$j + 1] > $a[$j]) {
            ++$j;
        }  
        last if $a[$pos] >= $a[$j];
        @a[$pos, $j] = @a[$j, $pos];
        $pos = $j;
    }  
}
 
@a = 0 .. $N-1;
 
pushDown($_, $N) for reverse 0 .. $N / 2;
 
my $n = $N;
while ($n > 1) {
    @a[0, $n - 1] = @a[$n - 1, 0];
    --$n;
    pushDown(0, $n);
}
 
while (my ($id, $key) = each @a) {
    die unless $id == $key;
}
 
my $end_time = gettimeofday;
print "Done in ", int(1000 * ($end_time - $start_time)), " ms\n";
