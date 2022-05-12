package Form;

use strict;
use warnings;

use Data::Dumper;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(render);

sub elem {
  my %elem = %{$_};
  my @keys = keys(%elem);
  my $key = $keys[0];
  my $label = $elem{$key};

  my $hidden = $key =~ /^__/;
  if($hidden) {
    $key = substr($key, 2);
  }

  return <<EOT
    <li class="component__form__input ${\( $hidden ? "component__form__hidden" : "" )}">
      <label for="$key">$label</label>
      <input type="text" name="$key" id="$key" value="${\( $hidden ? $label : "" )}">
    </li>
EOT
}

sub render {
  my $action = shift;
  my @form = @_;

  return <<EOF
    <form action="/cgi-bin/assignment10/actions/$action">
      <ul class="component__form">
        ${\( join("\n", map(elem, @form)))}
        <button type="submit">🛫 Send</button>
      </ul>
    </form>
EOF
;
}
