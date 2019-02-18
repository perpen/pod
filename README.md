FLOW
====
- Image build - Dockerfile
    - Copies scripts to /pod
    - Installs packages
    - Creates pair user
- Container start - /pod/entrypoint
    - Creates user
    - Calls /pod/user-init under user's uid
        - Clones user's linux-home
- Login
    - /pod/pod-profile.sh called by user's .bash_profile
        - Decrypts user secrets
        - Clones projects into ~/src        
        - Starts tmux

LINUX-HOME REPO SETUP
=====================
```
# Fork <linux-home skel url> into your personal repo in stash
# Use the same name for the repo.
# Then customise your fork.
$ git clone <your linux-home repo>
$ cd linux-home
# Install there all your secrets, in the standard locations.
# E.g. copy your ssh keys to .ssh/
# Then you can move your secret files into the .pod/secret tree
# by running for example:
$ ./bin/seed-secrets seed .ssh/id_rsa* .npmrc
# Check what the script did:
$ find . -type l -ls
# Encrypt .pod/secret into .pod-secrets.gpg
$ ./bin/seed-secrets encrypt
# Add the encrypted file to git, as well as your secret symlinks
$ git add .pod-secrets.gpg .ssh/id_rsa*
```
- Source /pod/pod-profile.sh from your .bash_profile
- tmux config
- .gitignore: .pod/secrets, .pod/profiled, .pod/args

TODO
====
- expose port in container - tcp auto-ingress?
- portal:
  - input: linux-home url required, projects urls optional
  - portal is a k8s app which gets info from url or form, then redirects to
    the new pod.
  - http://localhost:3000/pod?projects=FXT/bundle-keepie:policies,43880338/noci
  - support branches. what if multiple branches of same repo? not happen
- project specifics
  - project can have .pod config with preferred image and optionally version
- ldap login (either integrated, or on login)
  - why would i need it? what's the risk if i create box using another's home files?
  - and some may choose to use a team account for this.
  - but secrets url could be a param. Have generic url params: linux-home, secrets,
    whatever - all of them with an init script.
    - eg: docker run pod joe \\
          http://stash/tooling/linux-home \\
          http://stash/joe/secrets \\
          --repos http://stash/fxt/model-t-build,http://stash/fxt/bundle-keepie
- copy/paste
- hostname on k8s
  See https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pods
- Name parameter? Appended to owner name (real name instead of staff id?)
- security:
  - ssl, supported by wetty
  - is it ok to give sudo?
  - alpine ok or need internal rhel7 image?
- pod-secrets decrypt should ask again if wrong passphrase
- random:
  - use terminal as ui, eg for portal or model-t
    - needs node to exit when done
    - use readline for input
- pairing
  - stop pairing when owner disconnects. is timeout still necessary?
- garbage collecting
  - delete container w/o connection for 2 hours
- fancy stuff
  - initialise tmux with 1 window per project, and the 3 panes
- find simple init method for tmux
- tab title should be pod name
- use chromium standalone app to get all keyboard shortcuts?
