# Scripts

Scripts meant for various use-cases. Sometimes useful when run as cronjobs.

## Crontab

Example root crontab (`sudo crontab -e`). Use [crontab.guru](https://crontab.guru/) to help write cronjobs.

```bash
SHELL=/bin/bash
SCRIPTS=/home/ben/dotfiles/scripts

# Update system every day at 12pm and write all STDOUT/STDERR to a logfile.
0 12 * * * "$SCRIPTS"/update-system.sh && /tmp/dotfiles/logs/update-system.log 2>&1
```
