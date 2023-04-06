resource "flexibleengine_obs_bucket" "CV_storage_bucket" {
  bucket = "CV.storage.bucket"
  acl    = "public-read"
  storage_class = "STANDARD"
}