package WithID;

use strict;
use warnings;

use Data::Dumper;

use Exporter;
our @ISA = qw(Exporter);

sub new {
  return (
    id => $_[0],
    payload => $_[1]
  )
}

sub get_id {
  my %self = %{$_[0]};

  if(!defined($self{"id"})) {
    die "FATAL: Could not get id from non-WithID object. Object was: ${\( Dumper(%self) )}";
  }

  return $self{"id"};
}

sub unwrap {
  my %self = %{$_[0]};

  if(!defined($self{"id"})) {
    die "FATAL: Unwrap on non-WithID. Object was: ${\( Dumper(%self) )}";;
  }

  return %{$self{"payload"}};
}
