# @api private
# This class handles unbound params. Avoid modifying private classes.
class unbound::params {
  if ($::operatingsystem != 'Ubuntu') {
    fail("${module_name} does not support ${::operatingsystem}")
  }

  $named_root_file    = '/etc/unbound/named.root'
  $cfg_file           = '/etc/unbound/unbound.conf'
  $cfg_dir            = '/etc/unbound/unbound.conf.d'
  $cfg_dir_sources    = ['puppet:///modules/unbound/conf.d']
  $package_ensure     = 'installed'
  $package_names      = ['unbound']
  $purge_cfg_dir      = true

  $server_options     = {
    'verbosity'             => 1,
    'num-threads'           => 1,
    'interface'             => ['0.0.0.0','::0'],
    'identity'              => '"rdns"',
    'hide-version'          => 'yes',
    'prefetch'              => 'yes',
    'prefetch-key'          => 'yes',
    # may provide a slight speedup and avoid TCP fallback
    'minimal-responses'     => 'yes',
    # Debug (to see validation failures and reasons)
    'val-log-level'         => 2,
    'use-caps-for-id'       => 'yes',
    'harden-below-nxdomain' => 'yes',
    # IPv4-mapped IPv6 address space should be considered private
    'private-address'       => '::ffff:0:0/96',
    # Do not connect to IPv6 link-local addresses
    'do-not-query-address'  => 'fe80::/10',
    'include'               => "\"${cfg_dir}/*.conf\"",
  }
}
