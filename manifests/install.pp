class mcollective::install {

  $setup_dir = $::mcollective::setup_dir

  package { 'dep_pkgs':
    name     => $::mcollective::pre_pkgs,
    provider => $::mcollective::provider,
    ensure   => present,
  }

  file { 'manual_pkgs':
    require => Package['dep_pkgs'],
    path    => $setup_dir,
    source  => $::mcollective::pkgs_dir,
    ensure  => directory,
    recurse => true,
    mode    => 0755,
    owner   => 0,
    group   => 0,
  }
  
  Exec {
    path      => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    require   => File['manual_pkgs'],
    logoutput => on_failure,
    timeout   => 300,
  }

  case $::operatingsystem {
    'RedHat','CentOS' : {
      exec { 'mcollective install':
        command => "rpm -Uvh $setup_dir/*.rpm",
        onlyif  => 'test ! -f /usr/libexec/mcollective/mcollective/agent/puppet.rb',
      }
    }
    'Ubuntu' : {
      exec { 'mcollective install':
        command => "dpkg -i $setup_dir/*.deb",
        onlyif  => 'test ! -f /usr/share/mcollective/plugins/mcollective/agent/puppet.rb',
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
