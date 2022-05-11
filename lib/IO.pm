package IO;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(read_all hoge);
our @EXPORT = qw(read_all hoge);

sub read_all {
  open FILE, $_[0];
  my $buf = "";

  while(<FILE>) {
    $buf = $buf . $_;
  }

  close FILE;

  return $buf;
}

sub hoge {
  return 5;
}
