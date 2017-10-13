#
# Class: unbound
#
class unbound (
  Hash $server_options                 = $unbound::params::server_options,
  Stdlib::Absolutepath $cfg_file       = $unbound::params::cfg_file,
  Stdlib::Absolutepath $cfg_dir        = $unbound::params::cfg_dir,
  Array[String] $package_names         = $unbound::params::package_names,
  String $package_ensure               = $unbound::params::package_ensure,
  Array[String] $cfg_dir_sources       = $unbound::params::cfg_dir_sources,
  Boolean $purge_cfg_dir               = $unbound::params::purge_cfg_dir,
) inherits unbound::params {
  contain unbound::install
  contain unbound::config
  contain unbound::exec
  contain unbound::service

  # do not notify the service class
  # since we want to check the config
  # before restarting
  Class['::unbound::install']
  -> Class['::unbound::config']
  -> Class['::unbound::exec']
  -> Class['::unbound::service']
}
