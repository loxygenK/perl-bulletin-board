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

sub render {
  die "FATAL: '_common' cannot be used as the page name" if $_[0] eq "_common";

  my $common_style = &IO::read_all("../styles/_common.css");
  my $style = &IO::read_all("../styles/$_[0].css");
  my $content = $_[1]->($cgi);

  print $content;
}

sub apply {

  die "FATAL: '_common' cannot be used as the page name" if $_[0] eq "_common";

  my $common_style = &IO::read_all("../styles/_common.css");
  my $style = &IO::read_all("../styles/$_[0].css");
  my $content = $_[1]->($cgi);

  print <<EOT
Content-Type: text/html; charset=UTF-8

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
    <meta name="viewport" content="width=device-width">
  </head>

  <body>
    <header class="header">
      <h1 class="header__logo">
        <a href="/cgi-bin/assignment10/index" class="header__logo__brand_link">
          <span class="header__logo__brand_name">
            Peranbull
          </span>
        </a>
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
  
  
  
  
  
  
  
  
  
  
