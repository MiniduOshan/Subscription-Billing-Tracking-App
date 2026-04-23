<?php

namespace App\Services;

use App\Repositories\DashboardRepository;

class DashboardService
{
    public function __construct(private readonly DashboardRepository $dashboardRepository)
    {
    }

    public function buildSummary(int $userId): array
    {
        return $this->dashboardRepository->summaryForUser($userId);
    }
}
