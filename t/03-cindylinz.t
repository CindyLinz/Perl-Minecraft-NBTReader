# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Minecraft-NBTReader.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More;
BEGIN { use_ok('Minecraft::NBTReader') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $sixtyfourbit = 0;
eval {
    my $foo = pack('q', 1);
    $sixtyfourbit = 1;
};

ok($sixtyfourbit, "pack() does not support 64bit quads!");
if(!$sixtyfourbit) {
    done_testing();
    exit;
}

my $reader = Minecraft::NBTReader->new();
ok(defined($reader), "new()");

for my $name (qw(CindyLinz jyanwei)) {
    ok(-f "t/$name.dat", "Found $name.dat");

    my %data = $reader->readFile("t/$name.dat");
    ok(1, "Load file $name.dat without crashing");

    if( $name eq 'CindyLinz' ) {
        cmp_ok(int $data{unnamed_0000001}{Pos}[2], '==', 336, 'Read correct');
    }
}


done_testing();
