package main

deny_required_label[msg] {
  not input.metadata.labels["app"]
  msg = sprintf("%s must include labels [app].", [input.metadata.name])
}
