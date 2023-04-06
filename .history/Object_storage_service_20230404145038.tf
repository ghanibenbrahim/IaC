resource "flexibleengine_obs_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "public-read"
  storage_class = "STANDARD"
}