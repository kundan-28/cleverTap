output "elb_dns_name" {
  value = aws_elb.wordpress.dns_name
}

# output "rds_endpoint" {
#   # value = aws_db_instance.main2.endpoint
# }
