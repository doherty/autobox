#!/usr/bin/perl

use strict;
use warnings;
use vars qw($WANT $DESCR);

use Test::More tests => 28;

BEGIN {
    $DESCR = [
        'basic',
        'no dup',
        'horizontal merge',
        'vertical merge',
        'horizontal merge of outer scope in inner scope',
        'dup in inner scope',
        'horizontal merge of inner scope in inner scope',
        'vertical merge in inner scope',
        'vertical merge in outer scope again',
        'merge DEFAULT into inner scope and unmerge ARRAY',
        'merge DEFAULT into top-level scope',
        'dup in sub',
        'horizontal merge in sub',
        'vertical merge in sub',
        'new scope with "no autobox"',
        'dup in new scope with "no autobox"',
        'horizontal merge in new scope with "no autobox"',
        'vertical merge in new scope with "no autobox"',
        'arrayref: two classes',
        'arrayref: one dup class',
        'arrayref: one dup class and one new namespace',
        'arrayref: one dup namespace and one new class',
        'arrayref: one new class',
        'arrayref: one new namespace',
        'arrayref: two default classes',
        'arrayref: one dup default class',
        'arrayref: one dup default class and one new default namespace',
        'arrayref: one new default class'
    ];

    $WANT = [

        # 1 - basic (line 259)
        {
            'SCALAR' => 'MyScalar1'
        },

        # 2 - no dup (line 260)
        {
            'SCALAR' => 'MyScalar1'
        },

        # 3 - horizontal merge (line 261)
        {
            'SCALAR' => 'MyScalar1, MyString1'
        },

        # 4 - vertical merge (line 262)
        {
            'ARRAY'  => 'MyArray1',
            'SCALAR' => 'MyScalar1, MyString1'
        },

        # 5 - horizontal merge of outer scope in inner scope (line 265)
        {
            'ARRAY'  => 'MyArray1',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar2'
        },

        # 6 - dup in inner scope (line 266)
        {
            'ARRAY'  => 'MyArray1',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar2'
        },

        # 7 - horizontal merge of inner scope in inner scope (line 267)
        {
            'ARRAY'  => 'MyArray1',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar2, MyString2'
        },

        # 8 - vertical merge in inner scope (line 268)
        {
            'ARRAY'  => 'MyArray1, MyArray2',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar2, MyString2'
        },

        # 9 - vertical merge in outer scope again (line 271)
        {
            'ARRAY'  => 'MyArray1, MyArray2',
            'HASH'   => 'MyHash3',
            'SCALAR' => 'MyScalar1, MyString1'
        },

        # 10 - merge DEFAULT into inner scope and unmerge ARRAY (line 275)
        {
            'ARRAY'  => 'MyDefault4',
            'CODE'   => 'MyDefault4',
            'HASH'   => 'MyHash3, MyDefault4',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault4'
        },

        # 11 - merge DEFAULT into top-level scope (line 279)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyDefault5',
            'CODE'   => 'MyDefault5',
            'HASH'   => 'MyHash3, MyDefault5',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault5'
        },

        # 12 - dup in sub (line 280)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyDefault5',
            'CODE'   => 'MyDefault5',
            'HASH'   => 'MyHash3, MyDefault5',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault5'
        },

        # 13 - horizontal merge in sub (line 281)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyDefault5',
            'CODE'   => 'MyDefault5',
            'HASH'   => 'MyHash3, MyDefault5',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault5, MyScalar5'
        },

        # 14 - vertical merge in sub (line 282)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyDefault5',
            'CODE'   => 'MyDefault5',
            'HASH'   => 'MyHash3, MyDefault5',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault5, MyScalar5',
            'UNDEF'  => 'MyUndef5'
        },

        # 15 - new scope with "no autobox" (line 287)
        {
            'SCALAR' => 'MyScalar6'
        },

        # 16 - dup in new scope with "no autobox" (line 288)
        {
            'SCALAR' => 'MyScalar6'
        },

        # 17 - horizontal merge in new scope with "no autobox" (line 289)
        {
            'SCALAR' => 'MyScalar6, MyString6'
        },

        # 18 - vertical merge in new scope with "no autobox" (line 290)
        {
            'ARRAY'  => 'MyArray6',
            'SCALAR' => 'MyScalar6, MyString6'
        },

        # 19 - arrayref: two classes (line 294)
        {
            'ARRAY'  => 'MyArray1, MyArray2',
            'HASH'   => 'MyHash3',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar7, MyScalar8'
        },

        # 20 - arrayref: one dup class (line 295)
        {
            'ARRAY'  => 'MyArray1, MyArray2',
            'HASH'   => 'MyHash3',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar7, MyScalar8'
        },

        # 21 - arrayref: one dup class and one new namespace (line 296)
        {
            'ARRAY'  => 'MyArray1, MyArray2',
            'HASH'   => 'MyHash3',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar7, MyScalar8, MyScalar10::SCALAR'
        },

        # 22 - arrayref: one dup namespace and one new class (line 297)
        {
            'ARRAY'  => 'MyArray1, MyArray2',
            'HASH'   => 'MyHash3',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar7, MyScalar8, MyScalar10::SCALAR, MyScalar11'
        },

        # 23 - arrayref: one new class (line 298)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyArray7',
            'HASH'   => 'MyHash3',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar7, MyScalar8, MyScalar10::SCALAR, MyScalar11'
        },

        # 24 - arrayref: one new namespace (line 299)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyArray7, MyArray8::ARRAY',
            'HASH'   => 'MyHash3',
            'SCALAR' => 'MyScalar1, MyString1, MyScalar7, MyScalar8, MyScalar10::SCALAR, MyScalar11'
        },

        # 25 - arrayref: two default classes (line 303)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyArray7, MyArray8::ARRAY, MyDefault6, MyDefault7',
            'CODE'   => 'MyDefault6, MyDefault7',
            'HASH'   => 'MyHash3, MyDefault6, MyDefault7',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault6, MyDefault7'
        },

        # 26 - arrayref: one dup default class (line 304)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyArray7, MyArray8::ARRAY, MyDefault6, MyDefault7',
            'CODE'   => 'MyDefault6, MyDefault7',
            'HASH'   => 'MyHash3, MyDefault6, MyDefault7',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault6, MyDefault7'
        },

        # 27 - arrayref: one dup default class and one new default namespace (line 305)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyArray7, MyArray8::ARRAY, MyDefault6, MyDefault7, MyDefault8::ARRAY',
            'CODE'   => 'MyDefault6, MyDefault7, MyDefault8::CODE',
            'HASH'   => 'MyHash3, MyDefault6, MyDefault7, MyDefault8::HASH',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault6, MyDefault7, MyDefault8::SCALAR'
        },

        # 28 - arrayref: one new default class (line 306)
        {
            'ARRAY'  => 'MyArray1, MyArray2, MyArray7, MyArray8::ARRAY, MyDefault6, MyDefault7, MyDefault8::ARRAY, MyDefault9',
            'CODE'   => 'MyDefault6, MyDefault7, MyDefault8::CODE, MyDefault9',
            'HASH'   => 'MyHash3, MyDefault6, MyDefault7, MyDefault8::HASH, MyDefault9',
            'SCALAR' => 'MyScalar1, MyString1, MyDefault6, MyDefault7, MyDefault8::SCALAR, MyDefault9'
        },

    ];
}

sub debug {
    my $hash = autobox::annotate(shift);
    my $descr = sprintf '%s (line %d)', shift(@$DESCR), (caller(2))[2];

=pod
    $| = 1;
    my $counter = 0 if (0);
    use Data::Dumper; $Data::Dumper::Terse = $Data::Dumper::Indent = $Data::Dumper::Sortkeys = 1;
    my $dump = Dumper($hash);
    chomp $dump;
    printf STDERR "# %d - %s\n", ++$counter, $descr;
    print STDERR "$dump,", $/, $/;
=cut

    is_deeply($hash, shift(@$WANT), $descr);
}

no autobox; # make sure a leading "no autobox" doesn't cause any underflow damage

{
    no autobox; # likewise a nested one
}

sub test1 {
    no autobox; # and one in a sub
}

use autobox SCALAR => 'MyScalar1', DEBUG => \&debug;
use autobox SCALAR => 'MyScalar1', DEBUG => \&debug;
use autobox SCALAR => 'MyString1', DEBUG => \&debug;
use autobox ARRAY  => 'MyArray1',  DEBUG => \&debug;

{
    use autobox SCALAR => 'MyScalar2', DEBUG => \&debug;
    use autobox SCALAR => 'MyScalar2', DEBUG => \&debug;
    use autobox SCALAR => 'MyString2', DEBUG => \&debug;
    use autobox ARRAY  => 'MyArray2',  DEBUG => \&debug;
}

use autobox HASH => 'MyHash3', DEBUG => \&debug;

sub sub2 {
    no autobox 'ARRAY';
    use autobox DEFAULT => 'MyDefault4', DEBUG => \&debug;
}

sub sub3 {
    use autobox DEFAULT => 'MyDefault5', DEBUG => \&debug;
    use autobox DEFAULT => 'MyDefault5', DEBUG => \&debug;
    use autobox SCALAR  => 'MyScalar5',  DEBUG => \&debug;
    use autobox UNDEF   => 'MyUndef5',   DEBUG => \&debug;
}

{
    no autobox;
    use autobox SCALAR => 'MyScalar6', DEBUG => \&debug;
    use autobox SCALAR => 'MyScalar6', DEBUG => \&debug;
    use autobox SCALAR => 'MyString6', DEBUG => \&debug;
    use autobox ARRAY  => 'MyArray6',  DEBUG => \&debug;
}

{
    use autobox SCALAR => [ 'MyScalar7', 'MyScalar8' ], DEBUG => \&debug;
    use autobox SCALAR => [ 'MyScalar7' ], DEBUG => \&debug;
    use autobox SCALAR => [ 'MyScalar7',    'MyScalar10::' ], DEBUG => \&debug;
    use autobox SCALAR => [ 'MyScalar10::', 'MyScalar11' ],   DEBUG => \&debug;
    use autobox ARRAY => [ 'MyArray7' ],   DEBUG => \&debug;
    use autobox ARRAY => [ 'MyArray8::' ], DEBUG => \&debug;
}

{
    use autobox DEFAULT => [ 'MyDefault6', 'MyDefault7' ], DEBUG => \&debug;
    use autobox DEFAULT => [ 'MyDefault6' ], DEBUG => \&debug;
    use autobox DEFAULT => [ 'MyDefault6', 'MyDefault8::' ], DEBUG => \&debug;
    use autobox DEFAULT => [ 'MyDefault9' ], DEBUG => \&debug;
}
