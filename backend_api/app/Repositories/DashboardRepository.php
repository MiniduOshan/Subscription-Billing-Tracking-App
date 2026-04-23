<?php

namespace App\Repositories;

use App\Models\Bill;
use App\Models\Payment;
use App\Models\Subscription;
use Carbon\Carbon;

class DashboardRepository
{
    public function summaryForUser(int $userId): array
    {
        $now = Carbon::now();
        $monthStart = $now->copy()->startOfMonth();
        $monthEnd = $now->copy()->endOfMonth();

        $paidThisMonth = Payment::query()
            ->where('user_id', $userId)
            ->whereBetween('payment_date', [$monthStart->toDateString(), $monthEnd->toDateString()])
            ->sum('amount');

        $upcoming = Bill::query()
            ->where('user_id', $userId)
            ->whereIn('status', ['pending', 'upcoming'])
            ->whereDate('due_date', '>=', $now->toDateString())
            ->orderBy('due_date')
            ->limit(5)
            ->get();

        return [
            'total_active_subscriptions' => Subscription::query()->where('user_id', $userId)->where('status', 'active')->count(),
            'total_unpaid_bills' => Bill::query()->where('user_id', $userId)->whereIn('status', ['pending', 'upcoming', 'overdue'])->count(),
            'total_paid_this_month' => (float) $paidThisMonth,
            'overdue_bills_count' => Bill::query()->where('user_id', $userId)->where('status', 'overdue')->count(),
            'monthly_expense_summary' => [
                'month' => $now->format('Y-m'),
                'amount' => (float) $paidThisMonth,
            ],
            'upcoming_due_payments' => $upcoming,
        ];
    }
}
