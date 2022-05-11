package Result;

use strict;
use warnings;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(post_def post_author post_content);
our @EXPORT = qw(post_def post_author post_content);

sub post_def {
  return (
    author => $_[0],
    content => $_[1]
  )
}

sub post_author {
  return $_[0]{"author"};
}

sub post_content {
  return $_[0]{"content"};
}
