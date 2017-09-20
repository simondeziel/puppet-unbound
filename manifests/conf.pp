# Define: unbound::conf
#
define unbound::conf (
  Hash $options,
  Stdlib::Absolutepath $target_file = "${unbound::cfg_dir}/${name}",
) {
  file { $target_file:
    content => epp('unbound/conf.epp', { 'options' => $options }),
    owner   => 0,
    group   => 0,
    mode    => '0644',
    notify  => Exec['unbound-restart'],
  }
}
