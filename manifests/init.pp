class chronograf (
    String $bind_ip        = $chronograf::params::bind_ip,
    String $bind_port      = $chronograf::params::bind_port,
    String $package_source = 'default',
) inherits chronograf::params {

    case $package_source {
        default: {
            package { $package_name:
                ensure => installed,
            }
        }
        'web': {
            ensure_packages(['wget'])

            exec { 'Download Chronograf Package':
                command => "wget ${package_url} -P /tmp",
                creates => "/tmp/${source}",
                path    => '/usr/local/bin/:/bin/',
                require => Package['wget'],
            }

            package { $package_name:
                ensure   => installed,
                provider => $provider,
                require  => Exec['Download Chronograf Package'],
                source   => "/tmp/${source}",
            }
        }
    }

    file { $config_file:
        ensure  => present,
        content => epp("${module_name}${config_file}.epp"),
        require => Package[$package_name],
    }

    service { $package_name:
        ensure    => running,
        #enable    => true, # TODO: Why is this broken...
        require   => Package[$package_name],
        subscribe => File[$config_file],
    }

}
