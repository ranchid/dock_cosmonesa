FROM php:8.2.28-fpm-bookworm AS base

RUN apt-get update && apt-get upgrade --no-install-recommends -y \
    && apt-get install --no-install-recommends -y \
    curl zip unzip git \
    # Laravel requirements
    libonig-dev libxml2-dev libpq-dev \
    ca-certificates \
    # php-gd requirements
    libpng-dev libjpeg-dev libfreetype-dev libzip-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) pdo_pgsql mbstring \
    exif pcntl bcmath \
    opcache zip soap intl

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

FROM base AS dev

ARG UID=1000
ARG GID=1000
ARG USERDEV=omkegams

RUN apt-get update && apt-get install --no-install-recommends -y \
    sudo bash-completion nano ssh

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${GID} ${USERDEV} \
    && useradd --uid ${UID} --gid ${GID} --shell /bin/bash --create-home ${USERDEV} \
    && usermod -aG sudo ${USERDEV} \
    && echo "${USERDEV} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN sed -i "s/user = www-data/user = ${USERDEV}/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i "s/group = www-data/group = ${USERDEV}/g" /usr/local/etc/php-fpm.d/www.conf

# RUN chown www-data:www-data -R /var/www/html \
#     && chmod -R 755 /var/www/html

# WORKDIR /var/www/html

USER ${USERDEV}
# RUN if [-f ./composer.json]; then \
#         composer install --no-interaction; \
#     fi

# ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD [ "php-fpm" ]


