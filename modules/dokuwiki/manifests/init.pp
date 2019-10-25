# vim: set ts=2 sw=2 et:
#
class dokuwiki {
}

class dokuwiki::download {

  # Télécharger le tgz
  exec {
    "dokuwiki::download::wget":
       command => "wget -O /usr/src/dokuwiki.tgz https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz",
       path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
       creates => "/usr/src/dokuwiki.tgz"
  }
	
  # Dézipper le tgz
  # - require télécharger
  exec {
    "dokuwiki::download::unzip":
      cwd => "/usr/src",
      command => "tar xavf dokuwiki.tgz && mv dokuwiki-2018-04-22b dokuwiki",
      path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
      creates => "/usr/src/dokuwiki",
      require => Exec["dokuwiki::download::wget"]
  }

}

define dokuwiki::install (
   $path
) {
  include php

  file {
    "dokuwiki::install for ${name}":
      path => $path,
      source => "/usr/src/dokuwiki",
      ensure => directory,
      recurse => true,
      owner => "www-data",
      recurselimit => 50,
      require => Exec["dokuwiki::download::unzip"]
  }

  include dokuwiki::download
}
