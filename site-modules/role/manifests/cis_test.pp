# 
class role::cis_test {
  notify { "some message": }
  include ::cis_profile
}
