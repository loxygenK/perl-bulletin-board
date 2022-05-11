package PostRepository;

use strict;
use warnings;

use adapter::IO;
use domain::Post;
use types::Result;
use repository::ID;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(post_new post_load);
our @EXPORT = qw(post_new post_load);

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
  return &Result::ok(\%post);
}

sub list {

}
