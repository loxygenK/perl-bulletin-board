package ReplyRepository;

use strict;
use warnings;

use adapter::IO;
use domain::Reply;
use repository::ID;
use types::Result;
use types::WithID;

use Exporter;
our @ISA = qw(Exporter);

sub add {
  my $post_id = &Reply::post_id($_[0]);
  my $author = &Reply::author($_[0]);
  my $content = &Reply::content($_[0]);

  my $id = ID::generate("reply/$post_id");
  my $path = &IO::store("reply/$post_id/$id");

  &IO::write_file($path, "$author\n$content");

  return $id;
}

sub get_by_id {
  my $post_id = $_[0];
  my $id = $_[1];
  open POST, &IO::store("reply/$post_id/$id") or return &Result::bad("Reply not found for Post #$post_id, Reply #$id");

  my $author = <POST>;
  my $content = "";
  while(<POST>) {
    $content = $content . $_;
  }

  my %reply = &Reply::new($post_id, $author, $content);
  my %reply_with_id = WithID::new($id, \%reply);
  return &Result::ok(\%reply_with_id);
}

sub latest_by_post_id {
  my $post_id = $_[0];
  my $count = $_[1];
  my $max_id = ID::get("reply/$post_id") or return ();

  my $start = $max_id < $count ? 1 : ($max_id - $count + 1);
  my $end   = $max_id;

  my @replies = ();
  foreach my $id ($start..$end) {
    my %maybe_reply = &get_by_id($post_id, $id);
    my %reply = Result::unwrap(\%maybe_reply);

    push(@replies, \%reply);
  }

  return @replies;
}
