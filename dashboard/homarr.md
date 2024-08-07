# Homarr

## Useful Links

- [Homarr Documentation - Getting Started](https://homarr.dev/docs/getting-started/installation/)
- [Homarr Official Website](https://homarr.dev/)

## Installation

To install Homarr using Docker Compose, follow these steps:

1. Create a file named `docker-compose.yml` and paste the following code into it:

    ```yaml
    version: '3.8'
    #---------------------------------------------------------------------#
    #     Homarr - A simple, yet powerful dashboard for your server.      #
    #---------------------------------------------------------------------#
    services:
      homarr:
        container_name: homarr
        image: ghcr.io/ajnart/homarr:latest
        restart: unless-stopped
        volumes:
    #     - /var/run/docker.sock:/var/run/docker.sock # Optional, only if you want Docker integration
          - ./homarr/configs:/app/data/configs
          - ./homarr/icons:/app/public/icons
          - ./homarr/data:/data
        ports:
          - '80:7575'
    ```

2. In the same directory, run the following command to start the Homarr container in the background:

    ```bash
    docker compose up -d
    ```
