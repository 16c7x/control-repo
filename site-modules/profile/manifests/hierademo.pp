# This class demos hiera
class profile::hierademo {
  notify { 'Hiera Message':
    message => lookup('message')
  }
}
