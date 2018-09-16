# sysctl

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with sysctl](#setup)
    * [Beginning with sysctl](#beginning-with-sysctl)
1. [Usage - Configuration options and additional functionality](#usage)
    * [Basic usage](#basic-usage)
    * [Multiple tab-separated values](#multiple-tab-separated-values)
    * [Custom target file](#custom-target-file)
    * [Setting multiple sysctl keys](#setting-multiple-sysctl-keys)
    * [Using hiera](#using-hiera)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
    * [Puppet 3 support](#puppet-3-support)
1. [License](#license)
1. [Authors](#authors)

## Description

[![Build Status](https://travis-ci.org/duritong/puppet-sysctl.png?branch=master)](https://travis-ci.org/duritong/puppet-sysctl)

This module manages the sysctl configuration (in /etc/sysctl.conf by default) and runtime
values.

## Setup

### Beginning with sysctl

To set a sysctl value in the configuration file and the runtime value. By default
sets the configuration in /etc/sysctl.conf by can be customized with the `target` parameter.

```puppet
sysctl::value { 'vm.nr_hugepages':
  value => '1583'
}
```

## Usage

### Basic usage

The basic usage by setting the configuration file and runtime value.

```puppet
sysctl::value { 'vm.nr_hugepages':
  value => '1583'
}
```

### Multiple tab-separated values

When setting a key that contains multiple values, use a tab to separate the values.

```puppet
sysctl::value { 'net.ipv4.tcp_rmem':
  value => "4096\t131072\t131072",
}
```

### Custom target file

If another config file then the default /etc/sysctl.conf is required.

```puppet
sysctl::value { 'vm.nr_hugepages':
  value  => '1583',
  target => '/etc/sysctl.d/mysysctl.conf',
}
```

### Setting multiple sysctl keys

To avoid duplication the sysctl::value calls multiple settings can be managed with
the `sysctl::values` resource.

```puppet
$my_sysctl_settings = {
  'net.ipv4.ip_forward'          => { value => 1 },
  'net.ipv6.conf.all.forwarding' => { value => 1 },
}

# Specify defaults for all the sysctl::value to be created
$my_sysctl_defaults = {
  require => Package['aa']
}

create_resources(sysctl::value, $my_sysctl_settings, $my_sysctl_defaults)

# or by using the sysctl::values resource
sysctl::values { 'multiple':
  args     => $my_sysctl_settings,
  defaults => $my_sysctl_defaults,
}
```

### Using hiera

You can configure hiera data and pass it to the `sysctl::values` resource.

```
sysctl::values:
  net.ipv4.ip_forward:
    value: 1
  net.ipv6.conf.all.forwarding:
    value: 1
```

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

For an extensive list of supported operating systems, see [metadata.json](https://github.com/duritong/puppet-sysctl/blob/master/metadata.json)

### Puppet 3 support

The 0.0.12 release is the last version that supports Puppet 3.

## License

Copyright (C) 2011 Immerda Project Group

sysctl is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

sysctl is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with sysctl. If not, see <http://www.gnu.org/licenses/>.

## Authors

This module is based on work by mh (mh@immerda.ch).
The following contributors have contributed to this module, in alphabetical order.

* Artem Sidorenko (artem-sidorenko)
* Beefsalad (beefsalad)
* Decibelhertz (decibelhertz)
* Dominic (dol)
* Duncan Ward (ddub)
* Duritong (duritong)
* Emilien Macchi (EmilienM)
* Jason Hancock (jasonhancock)
* Merritt Krakowitzer (mkrakowitzer)
* Mh (mh@immerda.ch)
* Nicolas Zin (nicolas.zin@savoirfairelinux.com)
* Patrick Debois (jedi4ever)
* Sebastian Reitenbach (buzzdeee)
* Stefan Möding (smoeding)
* Thracky (Thracky)
* Tobias Urdin (tobias-urdin)
