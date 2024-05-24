# resource "aws_acm_certificate" "main" {
#   domain_name       = "example2.com"
#   validation_method = "DNS"

#   tags = {
#     Name = "main_certificate"
#   }
# }


# resource "aws_route53_record" "cert_validation" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "www.example2.com"
#   type    = "A"
#   ttl     = 60
#   records = [aws_elb.wordpress.dns_name]
# }


# resource "aws_acm_certificate_validation" "main" {
#   certificate_arn         = aws_acm_certificate.main.arn
#   validation_record_fqdns = [aws_route53_record.www.fqdn]
# }



# ---------------------------------------------------------------------------------------------------

# resource "aws_acm_certificate" "main" {
#   # domain_name       = output.elb_dns_name
#   domain_name       = "example.com"
#   validation_method = "DNS"

#   tags = {
#     Name = "main_certificate"
#   }
# }

# resource "aws_acm_certificate_validation" "main" {
#   certificate_arn         = aws_acm_certificate.main.arn
#   validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
# }

# resource "aws_route53_record" "cert_validation" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = aws_acm_certificate.main.domain_name
#   type    = aws_acm_certificate.main.type
#   records = [each.value.value]
#   ttl     = 60
# }
