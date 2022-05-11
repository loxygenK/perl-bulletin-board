package PostRepository;

use strict;
use warnings;

use lib "../src";
use Post;

use lib "../lib";
use IO;
use Result;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(post_new post_load);
our @EXPORT = qw(post_new post_load);

sub generate_ID {
  my $id_path = &store("post_id");

  my $id = &read_all($id_path);
  my $new_id = $id + 1;

  &write_file($id_path, $new_id);

  return $new_id;
}

sub post_new {
  my $id = &generate_ID();
  my $path = &store("post/$id");

  my $author = post_author(%_[0]);
  my $content = post_content(%_[0]);

  &write_file($path, "$author\n$content");

  return $id;
}

sub post_load {
  my $id = $_[0];
  open POST, store("post/$id") or return result_bad("Post not found");

  my $author = <POST>;
  my $content = "";
  while(<POST>) {
    $content = $content . $_;
  }

  return &Result::result_ok(&post_def($author, $content));
}
