resource "aws_s3_bucket" "hosting_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.hosting_bucket.id
  key          = "index.html"
  source       = "../dist/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "index_js" {
  bucket       = aws_s3_bucket.hosting_bucket.id
  key          = "assets/index-DuGuS2xc.js"
  source       = "../dist/assets/index-DuGuS2xc.js"
  content_type = "application/javascript"
}

resource "aws_s3_object" "index_css" {
  bucket       = aws_s3_bucket.hosting_bucket.id
  key          = "assets/index-BbwWs9Rm.css"
  source       = "../dist/assets/index-BbwWs9Rm.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.hosting_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:GetObject"
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.hosting_bucket.arn}/*"
        Principal = {
          CanonicalUser = aws_cloudfront_origin_access_identity.origin_access_identity.s3_canonical_user_id
        }
      }
    ]
  })
}
