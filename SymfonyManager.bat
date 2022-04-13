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
echo SFTP server

echo.
echo Let's create something awesome!
set /p projectname=Enter the project name: 
echo.

echo Project %projectname% is being created now...
echo.
echo.

echo Would you like to install components (Mailer, Finder, Translator...)?
set /p input=yes / no: 
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

echo Require PHP...
echo.
call composer require php ">=7.4"
echo.

echo Install console component...
echo.
call composer require symfony/console
echo.

echo Install nelmio & roave security component...
echo.
call composer require nelmio/security-bundle
call composer require --dev roave/security-advisories:dev-latest
echo.

if %input%==yes echo Install filesystem component...
if %input%==yes echo.
if %input%==yes call composer require symfony/filesystem
if %input%==yes echo.

if %input%==yes echo Install sentry component...
if %input%==yes echo.
if %input%==yes call composer require sentry/sentry-symfony
if %input%==yes echo.

echo Install KnpTime component...
echo.
call composer require knplabs/knp-time-bundle
echo.

if %input%==yes echo Install finder component...
if %input%==yes echo.
if %input%==yes call composer require symfony/finder
if %input%==yes echo.

echo Install form component...
echo.
call composer require symfony/form
echo.

if %input%==yes echo Install http-client component...
if %input%==yes echo.
if %input%==yes call composer require symfony/http-client
if %input%==yes echo.

if %input%==yes echo Install mailer component...
if %input%==yes echo.
if %input%==yes call composer require symfony/mailer
if %input%==yes echo.

if %input%==yes echo Install notifier component...
if %input%==yes echo.
if %input%==yes call composer require symfony/notifier
if %input%==yes echo.

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
call composer require --dev symfony/var-dumper
echo.

echo Install debug component...
echo.
call composer require symfony/debug-bundle
echo.

if %input%==yes echo Install translator component...
if %input%==yes echo.
if %input%==yes call composer require symfony/translation
if %input%==yes echo.

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

if %input%==yes echo Install DOMPDF component...
if %input%==yes echo.
if %input%==yes call composer require dompdf/dompdf
if %input%==yes echo.

echo Install PHPUnit component...
echo.
call composer require --dev phpunit/phpunit symfony/test-pack
echo.

echo Install cache component...
echo.
call composer require symfony/cache
echo.

if %input%==yes echo Install encrypt-decrypt doctrine component...
if %input%==yes echo.
if %input%==yes call composer require michaeldegroot/doctrine-encrypt-bundle
if %input%==yes echo.

if %input%==yes echo Install UX components...
if %input%==yes echo.
if %input%==yes call composer require symfony/ux-chartjs
if %input%==yes call composer require symfony/ux-cropperjs
if %input%==yes call composer require symfony/ux-dropzone
if %input%==yes call composer require symfony/ux-lazy-image
if %input%==yes call composer require symfony/ux-swup
if %input%==yes echo.

echo Install YARN components...
echo.
call yarn install --force
call yarn encore dev
echo.

echo Install Schedule Bundle...
echo.
call composer require zenstruck/schedule-bundle
echo.

if %input%==yes echo Install Doctrine Enum Bundle...
if %input%==yes echo.
if %input%==yes call composer require fresh/doctrine-enum-bundle
if %input%==yes echo.

if %input%==yes echo Install Doctrine Extensions...
if %input%==yes echo.
if %input%==yes call composer require gedmo/doctrine-extensions
if %input%==yes call composer require stof/doctrine-extensions-bundle
if %input%==yes echo.

echo Install Twig Time Extension...
echo.
call composer require knplabs/knp-time-bundle
echo.

echo Set-Up Docker-Compose Dev Environment...
echo.
mkdir docker
robocopy .\..\templates\ .\ /s /e
echo.

echo Delete doctrine test env config file...
echo.
del config\packages\test\doctrine.yaml
del docker-compose.override.yml
del docker-compose.yml
echo.

echo Rename docker containers to project name...
echo.
powershell -Command "(gc docker-compose.yaml) -replace 'PROJECTNAME', '%projectname%' | Out-File -encoding ASCII docker-compose.yaml"
powershell -Command "(gc .env) -replace 'db:3306', '%projectname%_db:3306' | Out-File -encoding ASCII .env"
powershell -Command "(gc .gitlab-ci.yml) -replace 'docker exec php', 'docker exec %projectname%_php' | Out-File -encoding ASCII .gitlab-ci.yml"
powershell -Command "(gc docker\nginx\conf.d\default.conf) -replace 'server php:9000;', 'server %projectname%_php:9000;' | Out-File -encoding ASCII docker\nginx\conf.d\default.conf"
powershell -Command "(gc composer.json) -replace '>=7.2.5', '>=7.4.0' | Out-File -encoding ASCII composer.json"
echo.

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