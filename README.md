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

Base config:

```bash
$ cp .env.example .env
```

Config for each workspace:

```bash
$ cp .env.workspace.example .env.<workspace name>
```

... set variables and run ...

```bash
$ make install
```
