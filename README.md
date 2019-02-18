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
- Secrets - how to seed it simply?
- tmux config
- .gitignore: .pod-secrets, .pod-profiled, .pod-args

FILES
=====
- Dockerfile
- entrypoint - dockerfile entry point
- pod - cli for use from the container
- rebuild
- user-init - called on container start to configure user account

TODO
====
- big issue: can't expose port in container
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
- garbage collecting
  - delete container w/o connection for 2 hours
- my own fancy stuff
  - initialise tmux with 1 window per project, and the 3 panes
- put all .pod-* files under ~/.pod/
- delete tmux layouts, or find simple init method
- tab title should be pod name
- use chromium standalone app to get all keyboard shortcuts?
