# blahajOS

An incomplete Alpine Linux desktop experience with GNOME (& KDE (future)) based on crunchpine.

Run `crystal run gen_mkimg.cr` to create the scripts.

## to build

```
docker build -t abuild .
docker run --privileged --cap-add=ALL -v /proc:/proc -v /sys:/sys -it -v $PWD:/home/build/aports/scripts/mnt --rm abuild
```
