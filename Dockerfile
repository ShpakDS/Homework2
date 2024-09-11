FROM php:8.3-fpm

# Оновлюємо пакети і встановлюємо необхідні залежності
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb

# Встановлюємо Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Встановлюємо робочу директорію
WORKDIR /var/www/html

# Спочатку копіюємо тільки файли composer для кешування залежностей
COPY composer.json composer.lock /var/www/html/

# Виконуємо установку залежностей Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Копіюємо весь проект
COPY src /var/www/html

# Відкриваємо порт 9000
EXPOSE 9000

# Запускаємо PHP-FPM
CMD ["php-fpm"]