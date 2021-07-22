# Tide - Show On Command

[![CI](https://github.com/branchvincent/tide-show-on-cmd/workflows/CI/badge.svg)](https://github.com/branchvincent/tide-show-on-cmd/actions/workflows/ci.yaml)

A [Tide](https://github.com/IlanCosman/tide) extension to enable [Powerlevel10k](https://github.com/romkatv/powerlevel10k)'s awesome [`show on command`](https://github.com/romkatv/powerlevel10k#show-on-command) feature.

## Installation

```shell
fisher install branchvincent/tide-show-on-cmd
```

## Configuration

First, add our item to the prompt:

```fish
set -a tide_right_prompt_items kubectl
```

Then, enable it to only show on certain commands:

```fish
set -gx tide_show_kubectl_on kubectl helm kubens kubectx stern
```

## Caveats

Note, this implementation is very naive compared to Powerlevel10k.
The current commandline is only queried when a space is entered.
