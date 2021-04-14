first send the install script to the nixos server.
```cat NixosInstall.bin | NIX_CHANNEL=nixos-20.09 bash 2>&1 | tee /tmp/infect.log```

then `ssh veo@ip-addr`

The dependencies are ready. Now you can [turn it on normally by downloading it from github](../turn_it_on.md)
