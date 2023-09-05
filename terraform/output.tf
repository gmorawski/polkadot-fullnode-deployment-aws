output "instance_az1_ip" {
  value = module.polkadot-az1[*].public_ip
}

output "instance_az2_ip" {
  value = module.polkadot-az2[*].public_ip
}
