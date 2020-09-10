# cd4pe
class profile::gitlab_server {
  class { 'gitlab':
    external_url => 'http://gitlab.mydomain.tld',
  }
}
