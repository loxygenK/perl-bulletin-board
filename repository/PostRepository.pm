package PostRepository;

use strict;
use warnings;

use adapter::IO;
use domain::Post;
use types::Result;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(post_new post_load);
our @EXPORT = qw(post_new post_load);

sub generate_ID {
  my $id_path = &IO::store("post_id");

  my $id = &IO::read_all($id_path);
  my $new_id = $id + 1;

  &IO::write_file($id_path, $new_id);

  return $new_id;
}

sub add {
  my $id = &generate_ID();
  my $path = &IO::store("post/$id");

  my $author = &Post::author(%_[0]);
  my $content = &Post::content(%_[0]);

  &IO::write_file($path, "$author\n$content");

  return $id;
}

sub get_by_id {
  my $id = $_[0];
  open POST, &IO::store("post/$id") or return &Result::bad("Post not found");

  my $author = <POST>;
  my $content = "";
  while(<POST>) {
    $content = $content . $_;
  }

  return &Result::ok(&Post::new($author, $content));
}
