# Terraform Module NodeJS Package

This module packages the nodejs module code. It scans the target directories and outputs
map of filename to filepaths for files matching to specified pattern.

This is a helper module to build NodeJS modules with terraform.

The output of this module can be combined with other modules to construct module dependencies.
This module will NOT do dependency resolution of child modules, it simply adds dependencies of
sub-modules to `node_modules` directory of each sub-module.

## Example

Package all `*.js` files from `src` directory.

```hcl
module "code" {
  source  = "cloudventure-io/package/nodejs"
  version = "~> 1.0"

  files = [
    {
      path    = "${path.module}/src"
      include = ["*.js"]
      exclude = ["\\.test\\.js$"]
    },
    {
      path    = "${path.module}"
      include = ["LICENSE"]
      exclude = []
    },
  ]
}

output "name" {
  value = "my-module"
}

output "files" {
  value = module.code.files
}
```
