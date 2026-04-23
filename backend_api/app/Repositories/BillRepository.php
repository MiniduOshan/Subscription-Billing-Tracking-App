<?php

namespace App\Repositories;

use App\Models\Bill;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class BillRepository
{
    public function paginatedForUser(int $userId, array $filters = []): LengthAwarePaginator
    {
        $query = Bill::query()
            ->with(['subscription'])
            ->where('user_id', $userId);

        if (! empty($filters['status'])) {
            $query->where('status', $filters['status']);
        }

        if (! empty($filters['search'])) {
            $search = $filters['search'];
            $query->where(function ($builder) use ($search) {
                $builder->where('title', 'like', "%{$search}%")
                    ->orWhere('notes', 'like', "%{$search}%");
            });
        }

        $sortBy = $filters['sort_by'] ?? 'due_date';
        $sortDir = $filters['sort_dir'] ?? 'asc';

        return $query->orderBy($sortBy, $sortDir)->paginate((int) ($filters['per_page'] ?? 15));
    }
}
