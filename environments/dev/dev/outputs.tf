# output "url" {
  # value = module.ec2.url
# }


output "url" {
  value = "http://${module.alb.dns_name}"
}