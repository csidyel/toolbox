#!/usr/bin/env bats

load "../support/bats-support/load"
load "../support/bats-assert/load"

setup() {
  source /tmp/.env-*
  export PATH="/home/semaphore/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  set -u
  source ~/.toolbox/toolbox
}

#  Ruby
@test "change ruby to 2.7.8" {

  run sem-version ruby 2.7.8
  assert_success
  run ruby --version
  assert_line --partial "ruby 2.7.8"
}

@test "change ruby to 3.0.6" {

  run sem-version ruby 3.0.6
  assert_success
  run ruby --version
  assert_line --partial "ruby 3.0.6"
}

@test "change ruby to 3.1.4" {

  run sem-version ruby 3.1.4
  assert_success
  run ruby --version
  assert_line --partial "ruby 3.1.4"
}

@test "change ruby to 3.2.1" {

  run sem-version ruby 3.2.1
  assert_success
  run ruby --version
  assert_line --partial "ruby 3.2.1"
}

@test "ruby minor versions test" {

  run sem-version ruby 2.7
  assert_success
  run ruby --version
  assert_line --partial "ruby 2.7.8"

  run sem-version ruby 3.0
  assert_success
  run ruby --version
  assert_line --partial "ruby 3.0.6"

  run sem-version ruby 3.1
  assert_success
  run ruby --version
  assert_line --partial "ruby 3.1.4"
}

@test "change ruby to 4.0.1" {

  run sem-version ruby 4.0.1
  assert_failure
}
