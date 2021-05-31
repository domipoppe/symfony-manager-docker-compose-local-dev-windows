# Symfony Windows Development Environment

This is a full development environment for Symfony based on Windows OS. It will create your Symfony project & deliver a full docker-compose dev stack. It will also install a set of composer packages which are useful.

Of course this is not the best package or so, but it fits my personal needs.

# Docker-Compose

- "php & nginx" PHP-FPM & Nginx as web server (http://localhost or http://127.0.0.1)
- "db" MariaDB as database (localhost:3306, user: root, password: rootPassword, db name: devDB)
- "redis" Redis for queues / cache (localhost:6379, no password)
- "phpmyadmin" PHPMYADMIN for GUI database management (http://localhost:6379)
- "mailhog" Mailhog (http://localhost:8025) - SMTP: localhost:1025
- "sftp" SFTP server (sftp://localhost:2222, user: foo, password: pass)
- .env file for Symfony pre-setup for the local dev environemnt (linked with the docker DB)

## Requirements

- PHP installed as local interpreter (**7.4**) -> https://www.sitepoint.com/how-to-install-php-on-windows/
- Symfony installed -> https://symfony.com/download
- Composer installed -> https://getcomposer.org/Composer-Setup.exe
- Docker installed -> https://docs.docker.com/docker-for-windows/install/

## Composer Packages

- symfony/console
- symfony/finder
- symfony/form
- symfony/http-client
- symfony/mailer
- symfony/notifier
- symfony/uid
- symfony/validator
- doctrine/annotations
- symfony/var-dumper
- symfony/translation
- phpstan/phpstan
- phpstan/extension-installer
- phpstan/phpstan-symfony
- dompdf/dompdf
- phpunit/phpunit
- symfony/test-pack
- php-translation/symfony-bundle

## How to get started?

Simply run the .bat file and enter your project name. It will create a folder in the folder where you call the .bat file with your project. It will now create a Symfony project and install all composer packages. It will now move the template folder files into that new folder.

**After that, you do this once to build the containers etc:**
- docker-compose pull
- docker-compose build

**In future when you want to start the dev environment, do:**
- docker-compose up -d
- docker-compose down (to stop the environment)

## Docker folder
Make sure to add the "docker" folder to your .gitignore file.
In the folder you will find folders containing data of the dockers.
In the nginx/logs folder you can find NGINX logs.
