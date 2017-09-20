# @api private
# This class handles unbound packages. Avoid modifying private classes.
class unbound::install inherits unbound {
  package { $unbound::package_names:
    ensure => $unbound::package_ensure,
  }
}
