# Subscription & Billing Tracking System Blueprint

## 1) Full Project Architecture

- Frontend: Flutter single codebase for Android, iOS, Web
- Backend: Laravel 12 REST API with token auth (Sanctum)
- Database: MySQL
- Communication: JSON over HTTPS
- Auth flow:
  - Register/Login returns token
  - Token sent in Authorization header
  - Logout revokes token
- Core domain modules:
  - Auth and user profile
  - Categories
  - Subscriptions
  - Bills as task items
  - Payments and history
  - Reminders and notification logs
  - Dashboard summary
  - Reports and analytics
  - Admin management

## 2) MySQL Database Schema

Implemented tables:
- users
- personal_access_tokens
- categories
- subscriptions
- bills
- payments
- reminders
- notification_logs
- activity_logs

Main relations:
- users 1:N subscriptions
- users 1:N bills
- users 1:N categories
- users 1:N payments
- subscriptions 1:N bills
- bills 1:N payments
- bills 1:N reminders

## 3) Laravel API Routes

Base prefix: /api/v1

Auth:
- POST /auth/register
- POST /auth/login
- POST /auth/forgot-password
- POST /auth/reset-password
- POST /auth/logout

Profile:
- GET /profile
- PUT /profile

Dashboard:
- GET /dashboard/summary
- GET /dashboard/activity

Categories:
- GET /categories
- POST /categories
- PUT /categories/{id}
- DELETE /categories/{id}

Subscriptions:
- GET /subscriptions
- POST /subscriptions
- GET /subscriptions/{id}
- PUT /subscriptions/{id}
- DELETE /subscriptions/{id}
- PATCH /subscriptions/{id}/status

Bills:
- GET /bills
- POST /bills
- GET /bills/{id}
- PUT /bills/{id}
- DELETE /bills/{id}
- PATCH /bills/{id}/mark-paid
- PATCH /bills/{id}/snooze

Payments:
- GET /payments
- POST /payments
- GET /payments/{id}

Reminders:
- GET /reminders
- PUT /reminders/{id}

Reports:
- GET /reports/monthly-spending
- GET /reports/category-spend
- GET /reports/paid-vs-unpaid

Admin:
- GET /admin/analytics/overview
- GET /admin/users
- GET /admin/users/{id}
- PATCH /admin/users/{id}/role

## 4) Laravel Controller/Module Structure

- app/Http/Controllers/Api/V1
  - AuthController
  - ProfileController
  - DashboardController
  - CategoryController
  - SubscriptionController
  - BillController
  - PaymentController
  - ReminderController
  - ReportController
  - Admin/UserManagementController
  - Admin/AdminAnalyticsController
- app/Services
  - RecurringBillingService
  - DashboardService
  - ReportService
  - ActivityLogService
- app/Repositories
  - SubscriptionRepository
  - BillRepository
  - PaymentRepository
  - DashboardRepository
- app/Models
  - Category, Subscription, Bill, Payment, Reminder, NotificationLog, ActivityLog

## 5) Flutter Folder Structure

- lib/main.dart
- lib/app.dart
- lib/core
  - config/app_config.dart
  - network/api_client.dart
  - theme/app_theme.dart
- lib/features
  - auth/presentation/screens
  - dashboard/presentation/screens
  - subscriptions/presentation/screens
  - bills/presentation/screens
  - calendar/presentation/screens
  - payments/presentation/screens
  - notifications/presentation/screens
  - profile/presentation/screens
  - admin/presentation/screens
  - shared/presentation/widgets

## 6) Flutter Screen List

Implemented:
- Splash screen
- Login screen
- Register screen
- Dashboard
- Subscription list
- Add subscription
- Edit subscription
- Subscription details
- Bills task list
- Calendar view
- Payment history
- Notifications
- Profile/settings
- Admin dashboard

## 7) State Management Suggestion

Recommended: Riverpod
- Keep UI state in feature-scoped providers
- Keep API state with AsyncNotifier family providers
- Keep auth token in secure local storage
- Keep immutable model classes per feature

## 8) Responsive UI Strategy

Mobile:
- Bottom navigation for core tabs
- Drawer for secondary sections
- Card-first layout
- Vertical content flow

Web/Desktop:
- NavigationRail sidebar
- Wider content panels with tables and cards
- Multi-column dashboard sections

## 9) Step-by-Step Development Plan

Phase 1: Foundation
- Environment setup
- Sanctum setup
- Migrations and seeders
- Basic auth endpoints

Phase 2: Core Billing Flow
- Subscription CRUD
- Bills task-style listing and filtering
- Mark paid and recurring generation
- Payment history endpoints

Phase 3: Dashboard and Reports
- Dashboard summary APIs
- Activity logs
- Monthly/category/status reports

Phase 4: Reminder and Notification Layer
- Reminder scheduler command
- Notification logs
- Push integration contracts

Phase 5: Flutter Integration
- Hook real API calls
- Auth token persistence
- Form validation and loading states
- Error handling and retries

Phase 6: Admin and Production Hardening
- Admin analytics pages
- Role and permission hardening
- Test coverage and CI/CD
- Observability and audit improvements

## 10) Optional Future Enhancements

- Team/shared workspace billing
- OCR receipt scanning
- AI anomaly detection on spend trends
- Stripe/Paddle recurring reconciliation
- Budget goals and smart alerts
- Multi-currency exchange support
- SaaS billing plans and tenant isolation

## Best Folder Structure Recommendations

Flutter:
- feature-first modules with data/domain/presentation sublayers as app grows
- shared core for theme/network/router/storage

Laravel:
- API versioned controllers
- request objects for validation
- service and repository separation
- policy-based authorization
- queued jobs for reminders/notifications

## Recommended Packages

Flutter:
- flutter_riverpod
- dio
- intl
- table_calendar
- fl_chart
- shared_preferences
- flutter_local_notifications

Laravel:
- laravel/sanctum
- laravel/pint
- laravel/pail
- optional: spatie/laravel-permission
- optional: laravel/horizon (if using Redis queues)

## Naming Conventions

Laravel:
- Controllers: PascalCase + Controller suffix
- Services: PascalCase + Service suffix
- Repositories: PascalCase + Repository suffix
- API route names grouped by resource and action
- DB columns: snake_case

Flutter:
- Files: snake_case
- Classes: PascalCase
- Providers: lowerCamelCase + Provider
- Widgets: suffix Screen, Card, Tile, Dialog

## Sample API Request/Response

Register request:
POST /api/v1/auth/register
{
  "name": "Jane User",
  "email": "jane@example.com",
  "password": "Password123!",
  "password_confirmation": "Password123!"
}

Register response:
{
  "message": "Registered successfully",
  "data": {
    "token": "1|token-value",
    "user": {
      "id": 1,
      "name": "Jane User",
      "email": "jane@example.com",
      "role": "user"
    }
  }
}

Mark bill paid request:
PATCH /api/v1/bills/12/mark-paid
{
  "payment_date": "2026-04-23",
  "payment_method": "Visa",
  "notes": "Paid from mobile app"
}

Mark bill paid response:
{
  "message": "Bill marked as paid",
  "data": {
    "bill": { "id": 12, "status": "paid" },
    "payment": { "id": 82, "amount": 29.0 },
    "next_bill": { "id": 83, "status": "upcoming" }
  }
}

## MVP to Advanced Roadmap

MVP:
- Auth
- Subscriptions
- Bills task list
- Mark paid
- Dashboard basic summary

V2:
- Reports and analytics
- Reminder scheduling
- Push-ready notification pipeline
- Calendar with bill drill-down

V3:
- Admin deep analytics
- Team and tenant support
- Payment gateway syncing
- Full SaaS packaging
