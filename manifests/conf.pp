# Define: unbound::conf
#
define unbound::conf (
  Enum['present','absent'] $ensure  = 'present',
  Optional[Hash] $options           = undef,
  Stdlib::Absolutepath $target_file = "${unbound::cfg_dir}/${name}",
) {
  if $ensure == 'present' and ! $options {
    fail('unbound::conf requires an options hash to be defined when the conf is present')
  }

  $content = $ensure ? {
   'present' => epp('unbound/conf.epp', { 'options' => $options, }),
    default  => undef,
  }

  file { $target_file:
    ensure  => $ensure,
    content => $content,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    notify  => Exec['unbound-restart'],
  }
}
