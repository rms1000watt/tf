terragrunt {
  terraform {
    // source = "git::git@github.com:rms1000watt/vtg-tf//apps/messaging?ref=0.1.0"
    source = "../../../../../apps/messaging"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
