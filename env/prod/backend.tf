terraform {
  backend "s3" {
    region           = "us-east-2"
    bucket           = "vule-s3-store-tfstates"
    profile          = "vuletest"
    key            = "terraform.tfstate"
        

  }
}
