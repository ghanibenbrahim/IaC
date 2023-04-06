resource "flexibleengine_obs_bucket" "b" {
  bucket = "ghanibuckettest"
  acl    = "public-read"
  storage_class = "STANDARD"
}