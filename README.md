# [DEV] Machine

## Requirements
- sshpass

## Before installation

Add to your `.ssh/config`:
```
Host < $DEV_MACHINE_HOST >
    Hostname < Real hostname or IP >
    User < existed user on remote host >
    AddKeysToAgent yes
    ForwardAgent yes
    IdentityFile < $DEV_MACHINE_IDENTITY_PATH >
```

## Install

```bash
$ cp .env.example .env
```

... set variables and run ...

```bash
$ make install
```
