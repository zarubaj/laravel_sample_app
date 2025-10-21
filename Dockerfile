FROM php:8.4-fpm-alpine AS php-fpm

RUN addgroup -g 1000 appuser && adduser -D -G appuser -u 1000 appuser

WORKDIR /var/www/html

ENV COMPOSER_HOME=./.composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

COPY . .
COPY ./public/build /var/www/html/public/build
COPY .env.ci .env

RUN composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader

RUN chown -R 1000:1000 /var/www/html \
    && chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

COPY docker/php-fpm/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown 1000:1000 /entrypoint.sh

USER 1000

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 9000
CMD ["php-fpm"]

# ─── Nginx image ───
FROM nginxinc/nginx-unprivileged:1.29-alpine AS nginx

COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /var/www/html/public/*
COPY ./public /var/www/html/public

EXPOSE 80
