# Docker Setup - Laravel React Inertia.js

## দ্রুত শুরু (Quick Start)

### 1. Environment সেটআপ
```bash
cp .env.example .env
# অথবা Docker এর জন্য:
cp env.docker.example .env
php artisan key:generate  # লোকালে চালালে
```

### 2. Development মোডে চালু করুন
```bash
# App + Nginx + MySQL + Node (Vite)
docker compose --profile dev up -d

# শুধু App + Nginx + MySQL (production build এর জন্য)
docker compose up -d
```

### 3. প্রথমবার Setup
```bash
# Node container চালু থাকলে Vite auto-run হবে
# না থাকলে একবার build করুন:
docker compose run --rm node npm run build
```

### 4. অ্যাপ অ্যাক্সেস করুন
- **Laravel App:** http://localhost:8000
- **Vite HMR:** http://localhost:5173 (dev mode এ)

---

## Services

| Service | Port | বর্ণনা |
|---------|------|--------|
| nginx | 8000 | Web server |
| app | 9000 (internal) | PHP-FPM |
| mysql | 3306 | MySQL Database |
| node | 5173 | Vite dev server (dev profile) |

---

## Commands

```bash
# Build & start
docker compose up -d --build

# Logs দেখা
docker compose logs -f app

# Artisan commands
docker compose exec app php artisan migrate
docker compose exec app php artisan db:seed

# Composer
docker compose exec app composer install

# Node/NPM (node service চালু থাকলে)
docker compose exec node npm run build
```

---

## Production Build

Production এ চালাতে:
```bash
docker compose up -d
docker compose exec node npm run build
```

অথবা build locally করে `public/build` commit করুন।
