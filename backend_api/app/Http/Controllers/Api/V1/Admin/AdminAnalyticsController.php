<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Models\Bill;
use App\Models\Payment;
use App\Models\Subscription;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class AdminAnalyticsController extends Controller
{
    public function overview(): JsonResponse
    {
        return response()->json([
            'data' => [
                'users_total' => User::count(),
                'subscriptions_total' => Subscription::count(),
                'bills_total' => Bill::count(),
                'payments_total' => Payment::count(),
                'payments_sum' => (float) Payment::sum('amount'),
                'overdue_bills_total' => Bill::where('status', 'overdue')->count(),
            ],
        ]);
    }
}
