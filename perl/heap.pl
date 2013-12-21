#!/usr/bin/perl

use strict;
use warnings;

use Time::HiRes 'clock';

sub pushDown {
	my $pos = shift;
	my $n = shift;
	my $h = shift;

	while (2 * $pos + 1 < $n) {
		my $j = 2 * $pos + 1;
		if ($j + 1 < $n && $h->[$j + 1] > $h->[$j]) {
			$j++;
		}
		if ($h->[$pos] >= $h->[$j]) {
			last;
		}
		($h->[$pos], $h->[$j]) = ($h->[$j], $h->[$pos]);
		$pos = $j;
	}
}

my $ticktock = clock();

my $N = 10_000_000;
my @h = (0 .. ($N - 1));

for (my $i = $N / 2; $i >= 0; $i--) {
	pushDown($i, $N, \@h);
}

my $n = $N;

while ($n > 1) {
	$n--;
	($h[0], $h[$n]) = ($h[$n], $h[0]);
	pushDown(0, $n, \@h);
}

for (my $i = 0; $i < $N; $i++) {
	print("$i != $h[$i]\n") and die if ($h[$i] != $i);
}

print("Done in " . (clock() - $ticktock) . "\n");
