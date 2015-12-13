# chronograf

## Module Description

[Chronograf](https://influxdata.com/time-series-platform/chronograf) is a single binary web application that you can deploy behind your firewall to do ad hoc exploration of your time series data in InfluxDB. This module installs Chronograf and provides the ability to customise the configuration. This module aims to be generic and simple.

## Setup

*What the chronograf Puppet module affects:*

* Package installation
* Service management
* Configuration files

## Usage

The minimum configuration required is to provide the URL's of your InfluxDB server(s) and include some base config:

```
include chronograf
```

This will simply call the package as a standard resource and thus assumes you have configured a repository that contains the package, be it your own or a third party. For most production environments this assumption should be appropriate as external access is often restricted.

If you do not have such restrictions and do not want to configure a repository you can simply request that the package be fetched from the internet:

```
class { 'chronograf':
    package_source => 'web',
}
```

### Hiera Support

It is recommended that Hiera is used, but not required. Below is an example configuration:

*site.pp*

```
hiera_include('classes', [])
```

*mynode.example.org.yaml*

```
clases:
    - chronograf

chronograf::bind_ip: 0.0.0.0
chronograf::package_source: web
```

## Reference

### Classes

Class: `chronograf`

Guides the basic setup and installation of Chronograf on your system.

When this class is declared with the default options, Puppet:

* Installs the appropriate Chronograf software package for your operating system (assumes you have a repository configured).
* Places the required configuration files in a directory, with the default location determined by your operating system.
* Starts the Chronograf service.

*Paramters within `chronograf`:*

`bind_ip`
The bind IP of the web server. Default: 127.0.0.1

`bind_port`
The bind port of the web server. Default: 10000

`package_source`
Determines how to install the package. Valid options: undef, 'web'. Default: undef

## Limitations

### Puppet Future Parser

This module is written using features that are found in the future parser and is not backwards compatible.

## Development

### Contributing

Please feel free to fork this module, make the appropriate changes in a feature branch, and submit a pull request.

### Running Tests

TBD
