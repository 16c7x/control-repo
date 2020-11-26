# gitlab server
class profile::sqlprofile {
  sqlserver_instance{ 'MSSQLSERVER':
    features                => ['SQL'],
    source                  => 'D:/',
    sql_sysadmin_accounts   => ['Administrator'],
  }
}
