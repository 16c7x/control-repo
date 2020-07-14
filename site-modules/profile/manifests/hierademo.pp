# This class demos hiera eyaml
class profile::hierademo {
  #notify { 'Hiera Message':
  #  message => lookup('message')
  #}
}
