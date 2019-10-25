
class apache {
  package {
    "apache2":
      ensure => present
  }

  service {
    "apache2": 
      ensure => running
  }
}

# prend 000-default.conf
# le copie dans ... ?
# remplacer quelques lignes
# a2ensite ...

define apache::vhost (
   $server_name,
   $document_root
) {

  # $vhost_name = $title

  include apache

  file {
    "apache::vhost::create ${server_name}.conf":
       path => "/etc/apache2/sites-available/${server_name}.conf",
       content => template("apache/vhost.conf.erb"),
       require => Package["apache2"]
  }

  exec {
    "apache::vhost::enable ${server_name}.conf":
      command => "a2ensite ${server_name}",
      require => File["apache::vhost::create ${server_name}.conf"],
      creates => "/etc/apache2/sites-enabled/${server_name}.conf"
  }
}


