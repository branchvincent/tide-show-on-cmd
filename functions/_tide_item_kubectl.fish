function _tide_item_kubectl --description "Show Kubernetes context"
    type -q kubectl || return
    set -l context (kubectl config view --minify --output 'jsonpath={.current-context}/{..namespace}' 2>/dev/null) &&
        echo (set_color magenta)⎈ (string replace --regex '/(|default)$' '' $context)
end
