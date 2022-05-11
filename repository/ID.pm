package ID;

use strict;
use warnings;

use adapter::IO;

use Exporter;
our @ISA = qw(Exporter);

sub get {
  my $id_path = IO::store("id/$_[0]");
  my $id = IO::read_all($id_path);

	return $id;
}

sub generate {
  my $id_path = IO::store("id/$_[0]");
  my $new_id = &get($_[0]) + 1;

  IO::write_file($id_path, $new_id);

  return $new_id;
}
