terragrunt {
  terraform {
    // source = "git::git@github.com:rms1000watt/tf.git//apps/orgs?ref=0.1.0"
    source = "../../../../apps//test-main/orgs"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
