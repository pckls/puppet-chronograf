class chronograf::params {

    $package_location = 'https://s3.amazonaws.com/get.influxdb.org'
    $package_name     = 'chronograf'
    $package_version  = '0.4.0'

    case $::osfamily {
        default: {
            fail("${::osfamily} is not supported.")
        }
        'Debian': {
            $provider = 'deb'
            $source   = "${package_name}_${package_version}_amd64.deb"
        }
        'RedHat': {
            $provider = 'rpm'
            $source   = "${package_name}-${package_version}-1.x86_64.rpm"

        }
    }

    $bind_ip     = '127.0.0.1'
    $bind_port   = '10000'
    $config_file = '/opt/chronograf/config.toml'
    $package_url = "${package_location}/${package_name}/${source}"

}
