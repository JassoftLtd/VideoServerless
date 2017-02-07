// CloudFront

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
    comment = "Origin Access Identity for Websitr"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [
    "aws_s3_bucket.dashvid-io-bucket",
    "aws_cloudfront_origin_access_identity.origin_access_identity"
  ]
    origin {
        domain_name = "${aws_s3_bucket.dashvid-io-bucket.website_domain}"
        origin_id   = "myS3Origin"

        s3_origin_config {
            origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    comment             = "DashVid.io Website"
    default_root_object = "index.html"

    aliases = ["www.${var.environment_subdomain}dashvid.io", "${var.environment_subdomain}dashvid.io"]

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "myS3Origin"

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    custom_error_response {
      error_caching_min_ttl = 0
      error_code = 404
      response_code = 200
      response_page_path = "/${aws_s3_bucket.dashvid-io-bucket.website.index_document}"
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}