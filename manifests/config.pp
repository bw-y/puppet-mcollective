class mcollective::config {
  file { $::mcollective::server_config:
    content => template($::mcollective::server_template),
    mode    => $::mcollective::config_mode,
    backup  => ".$::backup_date",
    owner   => 0,
    group   => 0,
  }
}
