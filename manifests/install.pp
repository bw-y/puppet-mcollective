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
  
  case $::osfamily {
    'Redhat': {
      exec { 'mcollective install':
        onlyif    => 'test ! -f /usr/libexec/mcollective/mcollective/agent/puppet.rb',
        path      => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
        command   => "rpm -Uvh $setup_dir/*.rpm",
        require   => File['manual_pkgs'],
        logoutput => on_failure,
        timeout   => 300,
      }
    }
    'Debian': {
      exec { 'mcollective install':
        onlyif    => 'test ! -f /usr/share/mcollective/plugins/mcollective/agent/puppet.rb',
        path      => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
        command   => "dpkg -i $setup_dir/*.deb",
        require   => File['manual_pkgs'],
        logoutput => on_failure,
        timeout   => 300,
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
