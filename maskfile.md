# Build documentation
Prepared and wrappped build commands

## clean
> Simple cleanup
```sh
nix-collect-garbage --delete-older-than 14d
```

## deepclean
> Run after manually removing boot entries
```sh
nix-collect-garbage
nix-collect-garbage -d
docker container prune 
docker image prune 
nix-collect-garbage --delete-older-than 14d
```

## listboot
> List all boot entries, remove with "sudo rm  /nix/var/nix/profiles/syst"
```sh
ls -ltr /nix/var/nix/gcroots/auto/*
```


## update
> Flake update
```sh
nix flake update
```

## home
> Update Home flake
```sh
home-manager switch --flake .#pero
```

## rebuild
> Rebuild Nix
```sh
sudo nixos-rebuild switch  --flake .#nixos --impure
```

## upgrade
> Upgrade and Rebuild Nix
```sh
sudo nixos-rebuild switch  --upgrade --flake .#nixos --impure
```

## list
> List Nix channels, get latest from "https://nixos.wiki/wiki/Nix_channels"
> Add new with nix-channel --add https://nixos.org/channels/channel-name nixos
```sh
nix-channel --list
```

