package PostRepository;

use strict;
use warnings;

use src::Post;

use lib::IO;
use lib::Result;

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

sub post_new {
  my $id = &generate_ID();
  my $path = &IO::store("post/$id");

  my $author = &Post::post_author(%_[0]);
  my $content = &Post::post_content(%_[0]);

  &IO::write_file($path, "$author\n$content");

  return $id;
}

sub post_load {
  my $id = $_[0];
  open POST, &IO::store("post/$id") or return &Result::result_bad("Post not found");

  my $author = <POST>;
  my $content = "";
  while(<POST>) {
    $content = $content . $_;
  }

  return &Result::result_ok(&Post::post_def($author, $content));
}
