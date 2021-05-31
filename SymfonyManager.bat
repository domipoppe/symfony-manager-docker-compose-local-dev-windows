@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

echo Symfony Windows Manager by Dominic Poppe (v0.1)...
echo.

echo Requires:
echo Symfony installed (https://symfony.com/download)
echo PHP installed (as local interpreter 7.4) (https://www.sitepoint.com/how-to-install-php-on-windows/)
echo Docker and Docker Compose installed (https://docs.docker.com/docker-for-windows/install/)
echo Composer installed (https://getcomposer.org/Composer-Setup.exe)
echo.

echo Docker Environment:
echo NGINX and PHP-FPM as web server
echo MariaDB as database
echo REDIS for queues/cache
echo PHPMYADMIN for GUI database management
echo Mailhog
echo SFTP server

echo.
echo Let's create something awesome!
set /p projectname=Enter the project name: 
echo.

echo Project %projectname% is being created now...
echo.
echo.

echo Update Symfony if possible...
echo.
call symfony self:update
echo.

echo Create Symfony Project...
echo.
call symfony new --full %projectname%
cd %projectname%

echo Install console component...
echo.
call composer require symfony/console
echo.

echo Install filesystem component...
echo.
call composer require symfony/filesystem
echo.

echo Install finder component...
echo.
call composer require symfony/finder
echo.

echo Install form component...
echo.
call composer require symfony/form
echo.

echo Install http-client component...
echo.
call composer require symfony/http-client
echo.

echo Install mailer component...
echo.
call composer require symfony/mailer
echo.

echo Install notifier component...
echo.
call composer require symfony/notifier
echo.

echo Install uuid component...
echo.
call composer require symfony/uid
echo.

echo Install validator and annotations component...
echo.
call composer require symfony/validator doctrine/annotations
echo.

echo Install var-dumper component...
echo.
call composer require symfony/var-dumper
echo.

echo Install translator component...
echo.
call composer require symfony/translation
echo.

echo Install PHPStan component...
echo.
call composer require --dev phpstan/phpstan
echo.

echo Install PHPStan Extension component...
echo.
call composer require --dev phpstan/extension-installer
echo.

echo Install Symfony PHPStan component...
echo.
call composer require --dev phpstan/phpstan-symfony
echo.

echo Install DOMPDF component...
echo.
call composer require dompdf/dompdf
echo.

echo Install PHPUnit component...
echo.
call composer require --dev phpunit/phpunit symfony/test-pack
echo.

echo Install Translation Admin WebGUI...
echo.
call composer require php-translation/symfony-bundle
echo.

echo Set-Up Docker-Compose Dev Environment...
echo.
mkdir docker
robocopy .\..\templates\ .\ /s /e

echo.
echo.
echo.
echo Finished!
echo Finished!
echo Finished!
echo.
echo.
echo.

pause