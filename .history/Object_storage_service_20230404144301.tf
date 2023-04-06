resource "flexibleengine_obs_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"
  storage_class = "STANDARD"
}