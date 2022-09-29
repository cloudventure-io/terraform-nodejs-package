variable "files" {
  description = <<EOS
The list of files for the modules.

`path` and `include` patterns are passed to `fileset` terraform function.
The syntax is as described [here](https://www.terraform.io/docs/language/functions/fileset.html).

`exclude` patterns are passed to `regexall` terraform function.
The syntax is as described [here](https://www.terraform.io/docs/language/functions/regexall.html).
EOS

  type = list(object({
    path    = string
    include = optional(list(string))
    exclude = optional(list(string))
  }))
}

variable "modules" {
  description = <<EOS
The list of sub-modules.

Each module will be included output files map under the directory `node_modules/$${name}`.
EOS

  default = []

  type = list(object({
    name  = string
    files = map(string)
  }))
}
