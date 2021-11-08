locals {
  files = {
    for file in flatten([
      for f in var.files : [
        for filename in flatten([for include in(f.include == null ? ["**"] : f.include) : fileset(f.path, include)]) : {
          filepath = "${abspath("${f.path}/${filename}")}"
          filename = filename
        }
        if alltrue([for exclude in(f.exclude == null ? [] : f.exclude) : length(regexall(exclude, filename)) == 0])
      ]
    ]) : file.filename => file.filepath
  }

  files_with_modules = merge(
    local.files,
    { for file in flatten([for m in var.modules : [
      for filename, filepath in m.files : {
        filepath = filepath
        filename = "node_modules/${m.name}/${filename}"
      }
      ]]) : file.filename => file.filepath
    }
  )
}
