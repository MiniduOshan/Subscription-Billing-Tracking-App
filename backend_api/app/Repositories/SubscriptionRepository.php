<?php

namespace App\Repositories;

use App\Models\Subscription;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class SubscriptionRepository
{
    public function paginatedForUser(int $userId, array $filters = []): LengthAwarePaginator
    {
        $query = Subscription::query()
            ->with(['category'])
            ->where('user_id', $userId);

        if (! empty($filters['status'])) {
            $query->where('status', $filters['status']);
        }

        if (! empty($filters['search'])) {
            $search = $filters['search'];
            $query->where(function ($builder) use ($search) {
                $builder->where('name', 'like', "%{$search}%")
                    ->orWhere('provider', 'like', "%{$search}%");
            });
        }

        return $query->latest()->paginate((int) ($filters['per_page'] ?? 15));
    }

    public function createForUser(int $userId, array $payload): Subscription
    {
        $payload['user_id'] = $userId;

        return Subscription::create($payload);
    }
}
