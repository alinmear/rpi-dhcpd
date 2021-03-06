load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

@test "checking if container fails without provided dhcpd.conf" {
  run $(docker logs dhcpd-without-config | grep '/docker-dhcpd/dhcpd.conf not found. Exiting ...' 2>&1 > /dev/null)
  assert_success
}

@test "checking dhcp is running" {
  run docker exec dhcpd /bin/bash -c "supervisorctl status| grep -E 'dhcpd.*RUNNING' 2>&1 > /dev/null"
  assert_success
}
