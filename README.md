FLOW
====
- Image build - Dockerfile
    - Copies scripts to /pod
    - Installs packages
    - Creates pair user
- Container creation - /pod/entrypoint
    - Creates user
    - Calls /pod/user-init under user's uid
        - Clones user's linux-home
- Login
    - /pod/pod-profile.sh called by user's .bash_profile
        - Decrypts user secrets
        - Clones projects into ~/src        
        - Starts tmux

INSTRUCTIONS
============
- Your own linux-home in stash, eg fork mine
- Source /pod/pod-profile.sh from your .bash_profile
- Secrets
- tmux config
- .gitignore: .pod-secrets, .pod-profiled, .pod-args

FILES
=====
Dockerfile
entrypoint - dockerfile entry point
pod-pairing - utility for sharing tmux session
pod - cli for calling from within container
rebuild
user-init - called after boot to configure user account

TODO
====
- portal:
  - nice urls, try avoiding ui
  - portal is a k8s app which gets info from url or form, then redirects to
    the new wetty.
  - http://localhost:3000/wetty?projects=FXT/bundle-keepie:policies,43880338/noci
  - support branches. what if multiple branches of same repo? not happen
- project specifics
  - project can have .pod config with preferred image and optionally version
- ldap login (either integrated, or on login)
  - do i need it? what's the risk if i create box using another's home files?
- hostname on k8s
  See https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pods
- Name parameter? Appended to owner name (real name instead of staff id?)
- security:
  - ssl, supported by wetty
  - safe way to give root?
- random:
  - use terminal as ui, eg for portal or model-t
    - needs node to exit when done
    - use readline for input
- garbage collecting
  - how to detect unused containers?
- my own fancy stuff
  - initialise tmux with 1 window per project, and the 3 panes
- delete tmux layouts, or find simple init method
