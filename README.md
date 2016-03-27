# Run Electron with Xvfb

Simply mount a volume containing the script you want to run in electron and use `docker run` to execute it.

```
docker run \
    --rm \
    --shm-size="4G" \
    -v /path/to/script:/path/to/script \
    dannysu/electron-headless \
    sh -c 'xvfb-run electron /path/to/script'
```

Adjust shm-size to half of your physical RAM.
