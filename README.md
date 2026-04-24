# Subscription & Billing Tracking App

A comprehensive solution for tracking subscriptions, managing bills, and monitoring expenses, built with Flutter, Laravel, and MySQL.

## 🚀 Features

- **Dashboard**: Real-time summary of active subscriptions and upcoming bills.
- **Subscription Management**: Track recurring services with details like cost, frequency, and category.
- **Bill Tracking**: Manage individual bill instances, mark them as paid, or snooze reminders.
- **Payment History**: Detailed logs of all past payments.
- **Reminders & Notifications**: Get notified before bills are due.
- **Reports & Analytics**: Insights into monthly spending and category-wise distribution.
- **Multi-platform Support**: Mobile (Android/iOS) and Web via Flutter.

---

## 🛠 Tech Stack

- **Frontend**: [Flutter](https://flutter.dev) (Dart)
- **Backend API**: [Laravel 12](https://laravel.com) (PHP)
- **Database**: [MySQL](https://www.mysql.com)
- **Authentication**: Laravel Sanctum (Token-based)

---

## 📁 Project Structure

- `mobile_app/`: Flutter application codebase.
- `backend_api/`: Laravel REST API codebase.

---

## ⚙️ Prerequisites

- Flutter SDK
- PHP 8.2+ & Composer
- MySQL Server
- Node.js & NPM (for Laravel frontend assets if needed)

---

## 🚥 Getting Started

### Backend Setup (Laravel)

1. Navigate to the backend directory:
   ```bash
   cd backend_api
   ```
2. Install dependencies:
   ```bash
   composer install
   npm install && npm run build
   ```
3. Setup environment configuration:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```
4. Configure your MySQL database in `.env`.
5. Run migrations and seeders:
   ```bash
   php artisan migrate --seed
   ```
6. Start the local server:
   ```bash
   php artisan serve
   ```

### Frontend Setup (Flutter)

1. Navigate to the mobile app directory:
   ```bash
   cd mobile_app
   ```
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Update the API base URL in your configuration (usually in `lib/core/constants/` or `.env`).
4. Run the application:
   ```bash
   flutter run
   ```

---

## 📄 License

This project is licensed under the MIT License.
