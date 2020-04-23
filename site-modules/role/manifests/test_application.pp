# 
class role::test_application {
  include ::profile::base
  notify { 'Test Application': }
}
