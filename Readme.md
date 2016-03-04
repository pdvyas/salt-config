### Self hosted Email

Heavily based on https://github.com/autocracy/salt_config


### Salt Master setup

Salt and pillar are in different repositories and the salt master mounts them as gitfs remotes. The salt config also uses the letsencrypt formula. The master config looks like,

```
fileserver_backend:
  - git

gitfs_remotes:
  - git@bitbucket.org:pdvyas/lab.pd.io-salt.git:
    - root: salt
  - https://github.com/saltstack-formulas/letsencrypt-formula.git

ext_pillar:
  - git: master git@bitbucket.org:pdvyas/lab.pd.io-pillar.git root=pillar
```

### Pillar

My pillar is private repository. You can structure your pillar as you like. Effective pillar on my setup is,

```
mail.lab.pd.io:
    ----------
    domain:
        lab.pd.io
    hello:
        world
    letsencrypt:
        ----------
        config:
            server = https://acme-v01.api.letsencrypt.org/directory
            email = m@pd.io
            authenticator = standalone
            agree-tos = True
            renew-by-default = True
        domainsets:
            ----------
            mail:
                - mail.lab.pd.io
    mail_aliases:
        root: pdvyas
    users:
        ----------
        pdvyas:
            ----------
            common_name:
                Pratik Vyas
            email:
                m@pd.io
            password:
                changemeplease
            public_keys:
                - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDesZwIuGzICe0dLUhAkoYF00UDoiwLyWHUgDVgRPlJrpxGoe6EwpSD/1ymvn0RZjloou53fH/itLPHAGt51fiKrqJThz1dbcFlFIblC324V/8tFOFmDL2r63ld0Re29pv0M9Iw4MFsCz6tafQnHlqf1iWRYq+Mlknc3fXTk4bHJFcbL2tvJ8T048otTCUhbpDh4jmgmBH0iIsblWsctrLjWMRaJEd+KGtFQXcLlfN31c0/aBmTXiziidTkAJD9HkniBuHa80Q3yxUME0zxX7x4NOcrk6F9GWiCNtIMgsMq1jCmiiTx+YDssUu48hVyWz9qEY7BXdmFG4/PZRFtU4gf
```

### DNS

* Reverse DNS: For digital ocean setting the droplet name as `mail.lab.pd.io` did this.
* MX Record: `lab.pd.io.		1798	IN	MX	10 mail.lab.pd.io.`

### Todo

* Add master.cf (enable submission)
* DKIM
* Spamassisin
* aliases as a key value pair from pillar
