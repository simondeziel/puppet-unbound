# @api private
# This class handles unbound packages. Avoid modifying private classes.
class unbound::install inherits unbound {
  package { $package_names:
    ensure => $package_ensure,
  }
}
