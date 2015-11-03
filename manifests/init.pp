class mcollective (
  $server              = true,
  $client              = false,

  $direct_addressing   = '1', 
  $connector           = 'activemq',
  $rabbitmq_vhost      = '/mcollective',
  $middleware_size     = '1',
  $middleware_hosts    = 'puppet.hypers.com.cn',
  $middleware_port     = '61613',
  $middleware_user     = 'mcollective',
  $middleware_password = 'pass',
  $plugin_psk          = 'changeStr',
  $loglevel            = 'info',
  $logfile             = '/var/log/mcollective.log',

  $identity            = undef,

  $service_enable      = true,
  $service_ensure      = 'running',

  $stage               = 'runtime'
) inherits ::mcollective::params {

  validate_bool($server)
  validate_bool($client)
  validate_string($loglevel)
  validate_absolute_path($logfile)
  validate_string($plugin_psk)
  validate_string($middleware_hosts)
  validate_numeric($middleware_port)
  validate_string($middleware_user)
  validate_string($middleware_password)

  anchor { 'mcollective::begin': } ->
  class { '::mcollective::install': } ->
  class { '::mcollective::config': } ~>
  class { '::mcollective::service': } ->
  anchor { 'mcollective::end': }

}
