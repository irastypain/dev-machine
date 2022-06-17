# [DEV] Machine

## Requirements
- git
- sshpass

## Before installation

Add to your `.ssh/config`:
```
Host <$DEV_MACHINE_HOST>
    Hostname <Real hostname or IP>
    User <Existed user on remote host>
    AddKeysToAgent yes
    ForwardAgent yes
    IdentityFile <Path to identity file>
```

## Install

Config for each workspace:

```bash
$ cp .env.workspace.example .env.<workspace name>
```

... set variables and run ...

Full installation:

```bash
$ make install_os workspace name=<workspace name>
```

Only set up workspace (OS must already be installed):

```bash
$ make workspace name=<workspace name>
```
