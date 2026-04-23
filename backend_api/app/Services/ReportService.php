<?php

namespace App\Services;

use App\Models\Bill;
use App\Models\Payment;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ReportService
{
    public function monthlySpending(int $userId, int $months = 6): array
    {
        $from = Carbon::now()->subMonths($months - 1)->startOfMonth();

        return Payment::query()
            ->selectRaw('DATE_FORMAT(payment_date, "%Y-%m") as month, SUM(amount) as total')
            ->where('user_id', $userId)
            ->whereDate('payment_date', '>=', $from->toDateString())
            ->groupBy(DB::raw('DATE_FORMAT(payment_date, "%Y-%m")'))
            ->orderBy('month')
            ->get()
            ->map(fn ($row) => [
                'month' => $row->month,
                'total' => (float) $row->total,
            ])
            ->all();
    }

    public function statusBreakdown(int $userId): array
    {
        return Bill::query()
            ->select('status', DB::raw('COUNT(*) as total'))
            ->where('user_id', $userId)
            ->groupBy('status')
            ->get()
            ->map(fn ($row) => [
                'status' => $row->status,
                'total' => (int) $row->total,
            ])
            ->all();
    }

    public function categorySpend(int $userId): array
    {
        return Payment::query()
            ->join('subscriptions', 'payments.subscription_id', '=', 'subscriptions.id')
            ->leftJoin('categories', 'subscriptions.category_id', '=', 'categories.id')
            ->where('payments.user_id', $userId)
            ->selectRaw('COALESCE(categories.name, "Uncategorized") as category, SUM(payments.amount) as total')
            ->groupBy('category')
            ->orderByDesc('total')
            ->get()
            ->map(fn ($row) => [
                'category' => $row->category,
                'total' => (float) $row->total,
            ])
            ->all();
    }
}
