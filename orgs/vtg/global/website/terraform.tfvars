terragrunt {
  terraform {
    // source = "git::git@github.com:rms1000watt/vtg-tf//apps/website?ref=0.1.0"
    source = "../../../../apps/website-vtg"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
