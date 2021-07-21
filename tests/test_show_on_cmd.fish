# RUN: %fish %s

set -gx tide_show_kubectl_on kubectl

set -l mocks '
mock type "-q kubectl" true
mock commandline -poc printf
mock kubectl "config view --minify --output" "echo context/namespace"
'

fish -ic "
$mocks
mock commandline -t 'echo notkubectl'
_tide_show_on_cmd
_tide_item_kubectl
"
# CHECK:

fish -ic "
$mocks
mock commandline -t 'echo kubectl'
_tide_show_on_cmd
_tide_item_kubectl
"
# CHECK: {{.*⎈ context/namespace}}
