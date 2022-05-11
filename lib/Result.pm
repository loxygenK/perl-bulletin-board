package Result;

use strict;
use warnings;

use Exporter;
our @ISA = qw(Exporter);

sub result_ok {
  return (
    status => "OK",
    payload => $_[0]
  );
}

sub result_bad {
  return (
    status => "BAD",
    error => $_[0]
  );
}

sub result_is_ok {
  return $_[0]{"status"} eq "OK"
}

sub unwrap {
  if(!result_is_ok($_[0])) {
    die "FATAL: Invalid unwrap occured. Error was: " . $_[0]{"error"};
  }

  return $_[0]{"payload"};
}
