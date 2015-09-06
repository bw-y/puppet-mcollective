class mcollective::params {
  
  $fs_dir              = 'puppet:///modules'
  $setup_dir           = '/opt/puppet_mcollective'
   
  $server_config       = '/etc/mcollective/server.cfg'
  $server_template     = 'mcollective/server.cfg.erb'
  $service_manage      = true
  $service_name        = 'mcollective'

  $main_collective     = 'mcollective'
  $collectives         = 'mcollective'

  $daemonize           = '1'
  $securityprovider    = 'psk'
  $factsource          = 'yaml'
  $plugin_yaml         = '/etc/mcollective/facts.yaml'

  case $::osfamily {
    'Debian' : {
      $config_mode = 0640
      $provider    = 'apt'
      $libdir      = '/usr/share/mcollective/plugins'
      $pkgs_dir    = "$fs_dir/$module_name/$::operatingsystem/$::lsbdistcodename"
      case $::lsbdistcodename {
        'trusty' : { $pre_pkgs = [ 'ruby-json' ] }
        'precise': { $pre_pkgs = [ 'rubygems1.8', 'ruby-json' ] }
        default: {
          fail("The ${module_name} module is not supported on an ${::lsbdistcodename} based system.")
        }
      }
    }
    'Redhat': {
      $provider     = 'yum'
      $config_mode  = 0644
      $pkgs_dir     = "$fs_dir/$module_name/$::osfamily/$::priosrelease"
      $libdir       = '/usr/libexec/mcollective'
      case $::priosrelease {
        '5' : { $pre_pkgs = ['tk'] }
        '6' : { $pre_pkgs = ['ruby-irb','ruby-rdoc','rubygems'] }
        default: {
          fail("The ${module_name} module is not supported on an ${::osfamily} - ${::priosrelease} based system.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
