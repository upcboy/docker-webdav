# docker-webdav
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
