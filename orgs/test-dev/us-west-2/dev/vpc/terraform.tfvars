terragrunt {
  terraform {
    // source = "git::git@github.com:rms1000watt/tf.git//apps/vpc?ref=0.1.0"
    source = "../../../../../apps//vpc"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

vpc_cidr_octet = "100"
