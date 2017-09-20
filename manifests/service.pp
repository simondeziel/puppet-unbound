# @api private
# This class handles unbound services. Avoid modifying private classes.
class unbound::service inherits unbound {
  service { 'unbound':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
