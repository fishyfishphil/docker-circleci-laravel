FROM circleci/php:7.1.14-cli-node-browsers

MAINTAINER fishyfishphil

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1
# https://getcomposer.org/doc/03-cli.md#composer-no-interaction
ENV COMPOSER_NO_INTERACTION 1

# Update composer
RUN sudo php $(which composer) self-update

# Install packages for testing
RUN composer global require "phpunit/phpunit" "squizlabs/php_codesniffer=3.*" "cakephp/cakephp-codesniffer=3.*" "codacy/coverage:dev-master" --optimize-autoloader --no-progress --no-suggest \
    && $(composer config home --global)/vendor/bin/phpcs --config-set installed_paths $(composer config home --global)/vendor/cakephp/cakephp-codesniffer

# Cleanup image
#RUN apt-get clean
