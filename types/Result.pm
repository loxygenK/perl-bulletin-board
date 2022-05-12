package Result;

use strict;
use warnings;

use Exporter;
our @ISA = qw(Exporter);

sub ok {
  return (
    status => "OK",
    payload => $_[0]
  );
}

sub bad {
  return (
    status => "BAD",
    error => $_[0]
  );
}

sub is_ok {
  my %self = %{$_[0]};

  return $self{"status"} eq "OK"
}

sub unwrap {
  my %self = %{$_[0]};

  if(!is_ok(\%self)) {
    die "FATAL: Invalid unwrap occured. Error was: " . $self{"error"};
  }

  return %{$self{"payload"}};
}

sub unprotect {
  my %self = %{$_[0]};

  if(!is_ok(\%self)) {
    return undef;
  }

  return %{$self{"payload"}};
}
