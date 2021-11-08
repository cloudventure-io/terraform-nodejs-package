output "files" {
  description = <<EOS
Map of `filename => filepath` entries, including sub-moduled.
EOS

  value = local.files_with_modules
}
