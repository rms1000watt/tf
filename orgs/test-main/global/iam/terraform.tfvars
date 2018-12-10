terragrunt {
  terraform {
    # source = "git::git@github.com:rms1000watt/tf.git//apps/iam?ref=0.1.0"
    source = "../../../../apps/test-main-iam"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
