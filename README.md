# Docker images with GBDK

## Building Docker images

### Building Docker image based on Ubuntu
```shell-script
docker build -t gstolarz/gbdk -t gstolarz/gbdk:2.96a .
```

### Building Docker image based on Alpine
```shell-script
docker build -t gstolarz/gbdk:alpine -t gstolarz/gbdk:2.96a-alpine \
  -f Dockerfile-alpine .
```
