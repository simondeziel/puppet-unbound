# Puppet Unbound

Manages Unbound server via Puppet.

## Requirements
* Ubuntu 16.04

## Usage

To run Unbound and allow the site network (192.0.2.0/24) to query it:


```puppet
  include unbound
  unbound::conf { 'site.conf':
    options => {
      'server' => {
        # query ACLs
        'access-control' => '192.0.2.0/24 allow',
      },
      'remote-control' => {
        'control-enable' => 'no',
      },
    }
  }
```

And to tell Unbound to forward requests to Cloudflare resolvers:

```puppet
  unbound::conf { "forward.conf":
    options => {
      'forward-zone' => {
        'name'         => '"."',
        'forward-addr' => [
                           '1.1.1.1',
                           '1.0.0.1',
                           '2606:4700:4700::1111',
                           '2606:4700:4700::1001',
                          ],
      },
    }
  }
```

Or if Unbound is recent enough (1.7.0+) using DNS over TLS to forward requests to Cloudflare resolvers:

```puppet
  unbound::conf { "forward.conf":
    options => {
      'server' => {
        'tls-cert-bundle' => '"/etc/ssl/certs/ca-certificates.crt"',
      }
      'forward-zone' => {
        'name'                 => '"."',
        'forward-tls-upstream' => 'yes',
        'forward-addr'         => [
                                   '1.1.1.1@853#cloudflare-dns.com',
                                   '1.0.0.1@853#cloudflare-dns.com',
                                   '2606:4700:4700::1111@853#cloudflare-dns.com',
                                   '2606:4700:4700::1001@853#cloudflare-dns.com',
                                  ],
      },
    }
  }
```
