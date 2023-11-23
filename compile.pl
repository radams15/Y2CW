#!/usr/bin/perl

sub preprocess {
    my ($in) = @_;

    my $out;

    open FH, '<', $in;
    for(<FH>) {
        if(/%include (.*)/) {
            open FH2, '<', $1;
            $out .= join("\n", <FH2>);
            close FH2;
        } else {
            $out .= "$_\n";
        }
    }

    return $out;
}

for(glob('*.html')) {
    next if (/^_.*/);
    my $out = &preprocess($_);

    open FH, '>', "out/$_";
    print FH $out;
    close FH;
}

system('cp -r js/ out/');
system('cp -r styles/ out/');
