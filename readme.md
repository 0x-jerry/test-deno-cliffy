# Setup

```sh
omz reload

./bin/tt completions zsh > tt.zsh

source ./source.zsh
```

# Reproduce

1. typing `tt deno `
2. then pressing `<tab>`

Now, we can see an error like this:

```sh
$ tt deno _arguments:463: command not found: script-script
tt
```
