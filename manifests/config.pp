# @api private
# This class handles unbound config. Avoid modifying private classes.
class unbound::config inherits unbound {
  # main config file
  unbound::conf { 'unbound.conf':
    options     => { 'server' => $server_options, },
    target_file => $cfg_file,
  }

  $cfg_dir_recurse = $purge_cfg_dir ? {
    true    => true,
    default => 'remote'
  }

  file { $cfg_dir:
    ensure       => directory,
    source       => $cfg_dir_sources,
    sourceselect => 'all',
    owner        => 0,
    group        => 0,
    mode         => 'u=rw+X,g=r+X,o=r+X',
    recurse      => $cfg_dir_recurse,
    purge        => $purge_cfg_dir,
    notify       => Exec['unbound-restart'],
  }
  file { $named_root_file:
    source  => 'puppet:///modules/unbound/named.root',
    owner   => 0,
    group   => 0,
    mode    => '0644',
    notify  => Exec['unbound-restart'],
  }
}
