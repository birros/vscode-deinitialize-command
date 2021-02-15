# VSCode Deinitialize Command

The purpose of this wrapper for `docker-compose` is to force [vscode][1] to
launch a custom command, defined in a property named `deinitializeCommand`, when
stopping a docker-compose stack. The `shutdownAction` property needs to be equal
to `stopCompose` in the `.devcontainer/devcontainer.json` file in order to see
vscode stop a `docker-compose` stack.

## Install

```shell
$ make install
# Override PATH env var for GUI apps (macOS)
$ cat << EOF > ~/Library/LaunchAgents/environment.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"\>
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>my.startup</string>
  <key>ProgramArguments</key>
  <array>
    <string>sh</string>
    <string>-c</string>
    <string>
      launchctl setenv PATH $HOME/.local/bin:/usr/local/bin:\$PATH
      killall Dock
      killall Spotlight
    </string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF
$ launchctl load -w ~/Library/LaunchAgents/environment.plist
```

## Use

Example of `.devcontainer/devcontainer.json` file:

```json
{
  "dockerComposeFile": ["../docker-compose.yml"],
  "service": "app",
  "workspaceFolder": "/var/www/html",
  "remoteUser": "www-data",
  "initializeCommand": "make up",
  // The following property is not a devcontainer property but is used by a
  // docker-compose wrapper script to run custom command when stopping
  // docker-compose stack
  "deinitializeCommand": "make stop",
  "shutdownAction": "stopCompose"
}
```

<!-- links -->

[1]: https://github.com/microsoft/vscode
