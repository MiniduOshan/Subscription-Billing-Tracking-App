<?php

namespace App\Repositories;

use App\Models\Payment;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class PaymentRepository
{
    public function paginatedForUser(int $userId, array $filters = []): LengthAwarePaginator
    {
        $query = Payment::query()
            ->with(['subscription', 'bill'])
            ->where('user_id', $userId)
            ->latest('payment_date');

        if (! empty($filters['subscription_id'])) {
            $query->where('subscription_id', $filters['subscription_id']);
        }

        return $query->paginate((int) ($filters['per_page'] ?? 15));
    }
}
