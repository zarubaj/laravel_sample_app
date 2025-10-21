# Laravel sample application

This is a simple application built with the Laravel framework.  
It serves as a minimal project for quickly getting started with Laravel.

## Requirements

- PHP **8.2** or higher
- Composer
- Web server (e.g., Apache, Nginx) or Laravel built-in server

## Installation

1. Install dependencies via Composer:

```bash
    composer install
```

2. Create the environment file:

```bash
   cp .env.example .env
```

3. Generate the application key:

```bash
    php artisan key:generate
```

4. Start the built-in Laravel server:

```bash
    php artisan serve
```
