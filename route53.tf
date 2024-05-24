# resource "aws_route53_zone" "main" {
#   name = "example2.com"
#   # name = aws_elb.wordpress.dns_name
#   # name = output.elb_dns_name
# }

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "www"
#   type    = "A"
#   alias {
#     name                   = aws_elb.wordpress.dns_name
#     zone_id                = aws_elb.wordpress.zone_id
#     evaluate_target_health = true
#   }
# }
