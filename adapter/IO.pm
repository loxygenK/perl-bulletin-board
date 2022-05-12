package IO;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(read_all write_file store);
our @EXPORT = qw(read_all write_file store);

sub read_all {
  open FILE, prepare_directory($_[0]) or die "Could not open file '$_[0]'";
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
  return prepare_directory("../storage/$_[0]")
}

sub prepare_directory {
  my @dir_elem = split(/\//, $_[0]);

  my $current_path = "";
  for(my $i = 0; $i < (scalar @dir_elem - 1); $i++) {
    $current_path = $current_path . $dir_elem[$i] . "/";

    if(! -e $current_path) {
      mkdir($current_path) or die "FATAL: Could not prepare directory at '$current_path'"
    }
  }

  return $_[0];
}
