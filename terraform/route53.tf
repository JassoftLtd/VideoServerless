resource "aws_route53_record" "DashCamAPI" {
  zone_id = "${var.dns_zone_id}"

  name = "${aws_api_gateway_domain_name.DashCamAPI.domain_name}"
  type = "A"

  alias {
    name                   = "${aws_api_gateway_domain_name.DashCamAPI.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.DashCamAPI.cloudfront_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "DashCamWeb" {
  zone_id = "${var.dns_zone_id}"
  name    = "${var.environment_subdomain}${var.dns_zone_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.website_s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.website_s3_distribution.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_DashCamWeb" {
  zone_id = "${var.dns_zone_id}"
  name    = "www.${var.environment_subdomain}${var.dns_zone_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.website_s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.website_s3_distribution.hosted_zone_id}"
    evaluate_target_health = true
  }
}
