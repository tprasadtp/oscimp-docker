# Dockerfiles for Buildroot

This repository is home for buildroots for plutosdr and redpitaya to be used with OscimpDigital.

![Travis (.com)](https://img.shields.io/travis/com/imtek-emp/oscimp-docker.svg)
![GitHub](https://img.shields.io/github/license/imtek-emp/oscimp-docker.svg)

## Credits

[Oscimp - Team](http://oscillator-imp.com/dokuwiki/doku.php)

## License

This repository is licensed under MIT License.
The licence only applies to this repository, please contact oscimp authrors for
license related to oscimp platform.

## Build

- Buildroot tarballs are available under [Github releases](https://github.com/imtek-emp/oscimp-docker/releases).
- They are built from latest commits for [Pluto](https://github.com/oscimp/PlutoSDR)
and [Redpitaya](https://github.com/trabucayre/redpitaya).
- They are built from commits `COMMIT_SHA` mentioned in `Dockerfile`, which can be changed
if necessary via docker build arguments.

## Usage

- Download the latest release from [Github releases](https://github.com/imtek-emp/oscimp-docker/releases) page.
- Unpack the tarball

  ```console
    tar -xzf buildroot-{buildrootversion}-{boardname}.tar.gz
  ```

- Follow instructions on [Oscimp github page](https://github.com/oscimp/oscimpDigital) ans set your `settings.sh`
accordingly.
