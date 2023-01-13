provider "postgresql" {
  host            = "postgres_server_ip"
  port            = 5432
  database        = "pchalo_test"
  username        = "chalo"
  password        = "chalo"
  sslmode         = "require"
  connect_timeout = 15
}