resource "aws_s3_bucket" "sample" {
  bucket = random_pet.petname.id
}