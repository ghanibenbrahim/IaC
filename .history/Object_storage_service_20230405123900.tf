resource "flexibleengine_obs_bucket" "CV_storage_bucket" {
  bucket = "cvstoragebucket"
  acl    = "public-read"
  storage_class = "STANDARD"
}