# @api private
# This class handles unbound exec actions. Avoid modifying private classes.
class unbound::exec inherits unbound {
  # check unbound's configs to avoid bad surprises
  exec { 'unbound-restart':
    command     => "/usr/sbin/unbound-checkconf ${cfg_file}",
    logoutput   => 'on_failure',
    refreshonly => true,
    notify      => Class['::unbound::service'],
  }
}
