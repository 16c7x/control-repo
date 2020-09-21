# gitlab server
class profile::gitlab_server {
  class { 'gitlab':
    external_url => 'http://gitlab-dev.platform9.puppet.net',
    #gitlab_rails => {
    #  'omniauth_allow_single_sign_on' => ['saml'],
    #  'omniauth_block_auto_created_users' => false,
    #},
  }
}
