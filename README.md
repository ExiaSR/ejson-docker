# ejson-docker

[![](https://images.microbadger.com/badges/version/exiasr/ejson.svg)](https://microbadger.com/images/exiasr/ejson "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/exiasr/ejson.svg)](https://microbadger.com/images/exiasr/ejson "Get your own image badge on microbadger.com")

Unofficial Docker image for [Shopify/ejson](https://github.com/Shopify/ejson), a utility for managing secrets in source control.

Build from [golang alpine-based image](https://hub.docker.com/_/golang), and the final image only contains the compiled binary, instead of the way how Shopify distributes the program via rubygems which introduces extra dependencies. The limitation is, it doesn't come with the `man` page.

## Usage

```bash
$ docker run --rm exiasr/ejson --version
```

Or make you own binary, move [bin/ejson](./bin/ejson) to somewhere in the `$PATH`. Make sure you set the `$EJSON_KEYDIR` variable in your shell startup script, i.e, `.bashrc`, `.zshrc`.

```bash
$ cat bin/ejson
#!/usr/bin/env bash

docker run --rm \
    -v "$EJSON_KEYDIR":/opt/ejson/keys \
    -v "$(pwd)":/secretsdir \
    exiasr/ejson "$@"

$ chmod +x bin/ejson
$ bin/ejson --version
```

### Generate a key pair

```bash
$ docker run --rm \
    -v $EJSON_KEYDIR:/opt/ejson/keys \
    -v $(pwd):/secretsdir \
    exiasr/ejson keygen -w
```

### Encrypt an ejson file

```bash
$ docker run --rm \
    -v $EJSON_KEYDIR:/opt/ejson/keys \
    -v $(pwd):/secretsdir \
    exiasr/ejson encrypt ./secrets.ejson
```

### Decrypt an ejson file

```bash
$ docker run --rm \
    -v $EJSON_KEYDIR:/opt/ejson/keys \
    -v $(pwd):/secretsdir \
    exiasr/ejson decrypt ./secrets.ejson > decrypted.json
```

## Author

- [Michael Lin](https://michaellin.me)

## License

Licensed under [MIT](./LICENSE).
