Nginx Proxy Manager (NPM) is a web-based application that simplifies the process of managing Nginx as a reverse proxy. It provides an easy-to-use Graphical User Interface (GUI) to configure and manage reverse proxy settings, SSL certificates, and domain-based routing.

Key Features of Nginx Proxy Manager:

1. User-Friendly Interface – No need to manually edit Nginx configuration files.


2. Reverse Proxy – Easily forward requests to internal services based on domains or subdomains.


3. SSL Management – Automated Let's Encrypt SSL certificate issuance and renewal.


4. Access Control – Restrict access to certain services using authentication.


5. Logging & Monitoring – Track and manage request logs via the UI.


6. Docker Support – Can be easily deployed using Docker and Docker Compose.



Use Case Examples:

Hosting multiple websites on a single server and forwarding traffic to different backend applications.

Securing web applications with HTTPS using Let's Encrypt.

Setting up a reverse proxy for self-hosted services like Nextcloud, Home Assistant, or Bitwarden.


How to Install Nginx Proxy Manager (Docker)?

1. Create a docker-compose.yml file:

version: "3"
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: always
    ports:
      - "80:80"
      - "81:81"
      - "443:443"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    environment:
      DB_MYSQL_HOST: "db"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "npm"
      DB_MYSQL_PASSWORD: "npm_password"
      DB_MYSQL_NAME: "npm_db"
  db:
    image: 'jc21/mariadb-aria:latest'
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: "root_password"
      MYSQL_DATABASE: "npm_db"
      MYSQL_USER: "npm"
      MYSQL_PASSWORD: "npm_password"
    volumes:
      - ./mysql:/var/lib/mysql


2. Run the container:

docker-compose up -d


3. Access the UI via http://your-server-ip:81

Default login:

Email: admin@example.com

Password: changeme

