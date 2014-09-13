Requirements
============

[![Build Status](https://travis-ci.org/duritong/puppet-sysctl.png?branch=master)](https://travis-ci.org/duritong/puppet-sysctl)

Overview
--------

This modules allows to configure sysctl.

Usage
-----

    node "mynode" inherits ... {
      sysctl::value { "vm.nr_hugepages": value => "1583"}
    }

When setting a key that contains multiple values, use a tab to separate the
values:

    node "mynode" inherits ... {
      sysctl::value { 'net.ipv4.tcp_rmem':
          value => "4096\t131072\t131072",
      }
    }

If another config file then /etc/sysctl.conf (default) is required, use target for this:

    node "mynode" inherits ... {
      sysctl::value { 'net.ipv4.tcp_rmem':
          value => "4096\t131072\t131072",
          target => '/etc/sysctl.d/mysysctl.conf',
      }
    }

To avoid duplication the sysctl::value calls multiple settings can be
managed like this:

    $my_sysctl_settings = {
      "net.ipv4.ip_forward"          => { value => 1 },
      "net.ipv6.conf.all.forwarding" => { value => 1 },
    }
    
    # Specify defaults for all the sysctl::value to be created (
    $my_sysctl_defaults = {
      require => Package['aa']
    }
    
    create_resources(sysctl::value,$my_sysctl_settings,$my_sysctl_defaults)

License
-------

Copyright (C) 2011 Immerda Project Group

Author mh <mh@immerda.ch>, Modified by Nicolas Zin <nicolas.zin@savoirfairelinux.com>, Modified by Artem Sidorenko <artem@2realities.com>

Licence: GPL v2
