resource "flexibleengine_obs_bucket" "b" {
  bucket = "ghani_bucket_test"
  acl    = "public-read"
  storage_class = "STANDARD"
}