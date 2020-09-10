# cd4pe
class profile::gitlab_server {
  class { 'gitlab':
    external_url => 'http://gitlab-dev.platform9.puppet.net',
  }
}
