name "webserver"
description "Simple Web App"
run_list(
  "recipe[python]",
  "recipe[mangroveapp]"
)
