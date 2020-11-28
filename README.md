rbbcc Omnibus project
=====================
This project creates full-stack platform-specific packages for
`rbbcc`!

![Test Building Result](https://github.com/udzura/omnibus-rbbcc/workflows/Test%20Build/badge.svg)

### Build

You create a platform-specific package using the `build project` command:

```shell
$ bundle install
$ bin/omnibus build rbbcc
```

Packages will be available in the `pkg/` folder. Only tested for Ubuntu Linux.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ bin/omnibus clean rbbcc
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/rbbcc`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ bin/omnibus clean rbbcc --purge
```

### Publish

Omnibus has a built-in mechanism for releasing to a variety of "backends", such
as Amazon S3. You must set the proper credentials in your
[`omnibus.rb`](omnibus.rb) config file or specify them via the command line.

```shell
$ bin/omnibus publish path/to/*.deb --backend s3
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ bin/omnibus help
```

Version Manifest
----------------

Git-based software definitions may specify branches as their
default_version. In this case, the exact git revision to use will be
determined at build-time unless a project override (see below) or
external version manifest is used.  To generate a version manifest use
the `omnibus manifest` command:

```
omnibus manifest PROJECT -l warn
```

This will output a JSON-formatted manifest containing the resolved
version of every software definition.
