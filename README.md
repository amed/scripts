# Scripts

## Remote Repository
This script helps to create a remote repository to handle deployment.

```
wget -O - https://raw.githubusercontent.com/amed/scripts/master/remote-repository.sh | bash
```

You need to create corresponding keys at `/home/git/.ssh/authorized_keys` to be able to push from local to remote - this step is left manually
