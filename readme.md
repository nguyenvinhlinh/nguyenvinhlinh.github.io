# Blog: hexalink.xyz

## 1. Build with docker for jenkins

- Build based image `hexalink_blog_base:latest`
```sh
$ docker build -f Dockerfile.base -t hexalink_blog_base:latest .
```

- Buid and extract `html files` in docker image
```sh
$ DOCKER_BUILDKIT=1 docker build -f  Dockerfile --target=release --output nginx-dist .
```
