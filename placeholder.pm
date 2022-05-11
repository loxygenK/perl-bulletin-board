#!/usr/bin/perl

package placeholder;

use strict;
use warnings;

use CGI;

use adapter::IO;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(placeholder);
our @EXPORT = qw(placeholder);

my $cgi = CGI->new;

sub placeholder {

  die "FATAL: '_common' cannot be used as the page name" if $_[0] eq "_common";

  my $common_style = &IO::read_all("../styles/_common.css");
  my $style = &IO::read_all("../styles/$_[0].css");
  my $content = $_[1]->($cgi);

  print <<EOT
Content-Type: text/html

<!-- -->

<!DOCTYPE HTML>
<html>
  <head>
    <style>
      /* ------- Common Style -------- */
      $common_style

      /* ------- Page-specific Style -------- */
      $style
    </style>
  </head>

  <body>
    <header class="header">
      <h1 class="header__logo">
        <span class="header__logo__brand_name">
          RaB2WoPerOX
        </span>
        <span class="header__logo__brand_catchcopy">
          <span>
            Random bulletin board
          </span>
          <span>
            working on Perl on XAMPP
          </span>
        </span>
      </h1>
      <button class="header__new_post">
        New post?
      </button>
    </header>

    <main class="main_content">
$content
      <!-- -->
    </main>
  </body>
</html>

<!--
EOT
  ;
}

# vim: set ft=html: -->
  
  
  
  
  
  
  
  
  
  
