# Secrets

This directory contains Ansible Vault encrypted secret files. 
These files are safe to commit to version control, as they are encrypted.

## Configuration

The repository's `ansible.cfg` is configured to look for the vault password file in `~/.vault_pass.txt`. 
Ensure that file exists on your local machine and contains your vault passphrase.

## Usage

### View a secret file
```bash
ansible-vault view secrets/acme.lab.yml
```

### Encrypt a new plaintext file

```bash
ansible-vault encrypt secrets/new_org.yml
```


