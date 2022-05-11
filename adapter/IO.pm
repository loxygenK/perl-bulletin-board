package IO;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(read_all write_file store);
our @EXPORT = qw(read_all write_file store);

sub read_all {
  open FILE, $_[0] or die "Could not open file '$_[0]'";
  my $buf = "";

  while(<FILE>) {
    $buf = $buf . $_;
  }

  close FILE;

  return $buf;
}

sub write_file {
  open FILE, "> $_[0]";
  print FILE $_[1];
  close FILE;
}

sub store {
  return "../storage/$_[0]"
}
