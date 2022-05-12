package Reply;

use strict;
use warnings;

use Exporter;
our @ISA = qw(Exporter);

sub new {
  return (
    post_id => $_[0],
    author => $_[1],
    content => $_[2]
  );
}

sub post_id {
  return %{$_[0]}{"post_id"}
}

sub author {
  return %{$_[0]}{"author"}
}

sub content {
  return %{$_[0]}{"content"}
}
