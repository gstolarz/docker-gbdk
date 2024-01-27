# Docker images with GBDK

## Building Docker images

### Building Docker image based on Ubuntu
```shell-script
docker build -t gstolarz/gbdk -t gstolarz/gbdk:2.96a \
  --build-arg GBDK_VERSION=2.96a .
```

### Building Docker image based on Alpine
```shell-script
docker build -t gstolarz/gbdk:alpine -t gstolarz/gbdk:2.96a-alpine \
  --build-arg GBDK_VERSION=2.96a -f Dockerfile-alpine .
```
