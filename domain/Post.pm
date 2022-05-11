package Post;

use strict;
use warnings;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(post_def post_author post_content);
our @EXPORT = qw(post_def post_author post_content);

sub new {
  return (
    author => $_[0],
    title => $_[1],
    content => $_[2]
  );
}

sub author {
  return %{$_[0]}{"author"};
}

sub title {
  return %{$_[0]}{"title"};
}

sub content {
  return %{$_[0]}{"content"};
}
