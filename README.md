# Quick Start

```shell
$ nix develop
$ nix run .#demo
$ sudo ss -lptn sport = :3000
```

The last command checks what's listening on port 3000. You should be seeing an
`async-hs` process, which is the server that was started by `demo`.

It is this server process that should be cleaned up at the end of the test,
ideally without shelling out to something like `pkill`.
