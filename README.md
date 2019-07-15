# Dockerfiles & Buildroot

This repository is home for buildroots for plutosdr and redpitaya to be used with OscimpDigital.

[![CircleCI](https://circleci.com/gh/tprasadtp/oscimp-docker/tree/master.svg?style=svg)](https://circleci.com/gh/tprasadtp/oscimp-docker/tree/master)![GitHub](https://img.shields.io/github/license/imtek-emp/oscimp-docker.svg)

## Credits

[Oscimp - Team](http://oscillator-imp.com/dokuwiki/doku.php)

## License

This repository is licensed under MIT License.
The license only applies to this repository, please contact respective reposiory authors/owners for
license related to other repos.

## Build

- Buildroot tarballs are available under [Github releases](https://github.com/imtek-emp/oscimp-docker/releases).
- They are built for [Pluto](https://github.com/oscimp/PlutoSDR)
and [Redpitaya](https://github.com/trabucayre/redpitaya).
- They are built from commits `COMMIT_SHA` mentioned in `Dockerfile`, which can be changed
if necessary via docker build arguments.

## Usage

- Download the latest release checksums from [Github releases](https://github.com/imtek-emp/oscimp-docker/releases) or Smaba share page.
- Get the buildroot tarballs from SAMBA file share(tarballs are too big for github Releases)
- Verify the checksum
  ```console
    sha1sum -c buildroot-{buildrootversion}-{boardname}.tar.gz.SHA1SUM
  ```
- Unpack the tarball

  ```console
    tar -xzf buildroot-{buildrootversion}-{boardname}.tar.gz
  ```

- Follow instructions on [Oscimp github page](https://github.com/oscimp/oscimpDigital) and set your `settings.sh`
accordingly.

## Links

### Oscimp

- [oscimp fpga sources](https://github.com/oscimp/fpga_ip)

### PlutoSDR

- [Buildroot Sources](https://github.com/oscimp/PlutoSDR)
- [gr-iio](https://github.com/analogdevicesinc/gr-iio)

### Redpitaya

- [Redpitaya Notes](https://pavel-demin.github.io/red-pitaya-notes/)
- [Buildroot Sources](https://github.com/trabucayre/redpitaya)

## Issues

- If you have issues using or building the buildroot, open an issue on [Github](https://github.com/imtek-emp/oscimp-docker/issues).

- Maintained by [Prasad Tengse](https://github.com/tprasadtp).
