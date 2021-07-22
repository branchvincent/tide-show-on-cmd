#RUN: %fish -i %s

set -gx tide_show_kubectl_on kubectl stern

mock commandline -poc printf
set -l mock_item '
mock type "-q kubectl" true
mock kubectl "config view --minify --output" "echo context/namespace"
_tide_item_kubectl
'

mock commandline -t 'echo notkubectl'
_tide_show_on_cmd
fish -c $mock_item
# CHECK:

mock commandline -t 'echo kubectl'
_tide_show_on_cmd
fish -c $mock_item
# CHECK: {{.*⎈ context/namespace}}

mock commandline -t 'echo stern'
_tide_show_on_cmd
fish -c $mock_item
# CHECK: {{.*⎈ context/namespace}}
