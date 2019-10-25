# vim: set ts=2 sw=2 et:


## dokuwiki server
#
# Note: on utilise une REGEXP pour matcher aussi bien
# - dokuserver.localdomain
# - dokuserver.infra.glenux.net

node /^dokuserver\..*/ {
  
  Exec { path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/' }

  # Installe les packages & services de base pour le 
  # fonctionnement du serveur

  # Déclarer/configurer un virtualhost pour chaque site
  apache::vhost {
    "collapse.wiki": 
     server_name => "collapse.wiki",
     document_root => "/var/www/collapse.wiki"
  }

  apache::vhost {
    "puppet.wiki": 
     server_name => "puppet.wiki",
     document_root => "/var/www/puppet.wiki"
  }
  
  # Installer dokuwiki dans chacun des dossiers
  dokuwiki::install {
    "collapse.wiki": 
      path => "/var/www/collapse.wiki",
  }
  dokuwiki::install {
    "puppet.wiki": 
      path => "/var/www/puppet.wiki",
  }
}


