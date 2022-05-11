package PostRepository;

use strict;
use warnings;

use adapter::IO;
use domain::Post;
use repository::ID;
use types::Result;
use types::WithID;

use Exporter;
our @ISA = qw(Exporter);

sub add {
  my $id = ID::generate("post");
  my $path = &IO::store("post/$id");

  my $author = &Post::author($_[0]);
  my $title = &Post::title($_[0]);
  my $content = &Post::content($_[0]);

  &IO::write_file($path, "$author\n$title\n$content");

  return $id;
}

sub get_by_id {
  my $id = $_[0];
  open POST, &IO::store("post/$id") or return &Result::bad("Post not found");

  my $author = <POST>;
  my $title = <POST>;
  my $content = "";
  while(<POST>) {
    $content = $content . $_;
  }

  my %post = &Post::new($author, $title, $content);
  my %post_with_id = WithID::new($id, \%post);
  return &Result::ok(\%post_with_id);
}

sub latest {
  my $count = $_[0];
  my $max_id = ID::get("post");

  my $start = $max_id < $count ? 1 : ($max_id - $count + 1);
  my $end   = $max_id < $count ? $count : $max_id;

  my @posts = ();
  foreach my $id ($start..$end) {
    my %maybe_post = &get_by_id($id);
    my %post = Result::unwrap(\%maybe_post);

    push(@posts, \%post);
  }

  return @posts;
}
