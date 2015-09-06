class mcollective::service {
  if ( $::mcollective::service_ensure in [ 'running', 'stopped' ] )  {
    service { $::mcollective::service_name:
      ensure     => $::mcollective::service_ensure,
      enable     => $::mcollective::service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
  } else {
    fail('service_ensure parameter must be running or stopped')
  }
}
