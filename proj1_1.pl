#!/usr/bin/perl

#Name: Hasnain Ali
#ID: JL69013
#Class: CMSC 433, SU23
#Prof: Dixon
#Filename: proj1_1.pl

use strict;
use warnings;

my $filename = 'proj1_data.txt';
open(my $fh, '<encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {
    chomp $row;
    $row =~ s/preparation(?=_time)/prep/g;
    $row =~ s/italian/Italian/g;
    $row =~ s/bolognese/Bolognese/g;
    $row =~ s/parmesan/Parmesan/g;
    if ($row =~ /(?<=<price>)(\d*)/) {
	my $price = $row;
	$price = substr($price, 11, -8);
	$price = $price + 1;
	$row =~ s/(?<=<price>)(\d*.\d{2})/$price/g;
    }
    if ($row =~ /(?<=<food_costs>)(\d*)/) {
        my $foodCosts = $row;
        $foodCosts = substr($foodCosts, 16, -13);
	$foodCosts = $foodCosts + 0.50;
	$foodCosts = sprintf("%.2f", $foodCosts);
        $row =~ s/(?<=<food_costs>)(\d*.\d{2})/$foodCosts/g;
    }
    print "$row\n" if $row =~ /\w/;
}
