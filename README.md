# docker-webdav

This is just a simple webdav setup I use for Joplin

## docker-compose
```
version: '3'
services:
  webdav:
    build: .
    container_name: webdav
    ports:
      - 8844:443
    restart: always
    environment:
      - USERNAME=user
      - PASSWORD=password
    volumes:
      - vol:/storage
volumes:
  vol:
```
