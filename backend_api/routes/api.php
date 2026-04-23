<?php

use App\Http\Controllers\Api\V1\Admin\AdminAnalyticsController;
use App\Http\Controllers\Api\V1\Admin\UserManagementController;
use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\BillController;
use App\Http\Controllers\Api\V1\CategoryController;
use App\Http\Controllers\Api\V1\DashboardController;
use App\Http\Controllers\Api\V1\PaymentController;
use App\Http\Controllers\Api\V1\ProfileController;
use App\Http\Controllers\Api\V1\ReminderController;
use App\Http\Controllers\Api\V1\ReportController;
use App\Http\Controllers\Api\V1\SubscriptionController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::prefix('auth')->group(function () {
        Route::post('register', [AuthController::class, 'register']);
        Route::post('login', [AuthController::class, 'login']);
        Route::post('forgot-password', [AuthController::class, 'forgotPassword']);
        Route::post('reset-password', [AuthController::class, 'resetPassword']);
    });

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('auth/logout', [AuthController::class, 'logout']);

        Route::get('profile', [ProfileController::class, 'show']);
        Route::put('profile', [ProfileController::class, 'update']);

        Route::get('dashboard/summary', [DashboardController::class, 'summary']);
        Route::get('dashboard/activity', [DashboardController::class, 'activity']);

        Route::apiResource('categories', CategoryController::class)->except(['show']);

        Route::apiResource('subscriptions', SubscriptionController::class);
        Route::patch('subscriptions/{subscription}/status', [SubscriptionController::class, 'changeStatus']);

        Route::apiResource('bills', BillController::class);
        Route::patch('bills/{bill}/mark-paid', [BillController::class, 'markPaid']);
        Route::patch('bills/{bill}/snooze', [BillController::class, 'snoozeReminder']);

        Route::apiResource('payments', PaymentController::class)->only(['index', 'store', 'show']);

        Route::apiResource('reminders', ReminderController::class)->only(['index', 'update']);

        Route::prefix('reports')->group(function () {
            Route::get('monthly-spending', [ReportController::class, 'monthlySpending']);
            Route::get('category-spend', [ReportController::class, 'categorySpend']);
            Route::get('paid-vs-unpaid', [ReportController::class, 'paidVsUnpaid']);
        });

        Route::middleware('admin')->prefix('admin')->group(function () {
            Route::get('analytics/overview', [AdminAnalyticsController::class, 'overview']);
            Route::get('users', [UserManagementController::class, 'index']);
            Route::get('users/{user}', [UserManagementController::class, 'show']);
            Route::patch('users/{user}/role', [UserManagementController::class, 'updateRole']);
        });
    });
});
