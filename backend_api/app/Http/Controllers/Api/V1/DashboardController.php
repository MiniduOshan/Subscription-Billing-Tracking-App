<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use App\Services\DashboardService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function __construct(private readonly DashboardService $dashboardService)
    {
    }

    public function summary(Request $request): JsonResponse
    {
        $summary = $this->dashboardService->buildSummary($request->user()->id);

        return response()->json([
            'data' => $summary,
        ]);
    }

    public function activity(Request $request): JsonResponse
    {
        $activities = ActivityLog::query()
            ->where('user_id', $request->user()->id)
            ->latest()
            ->limit(20)
            ->get();

        return response()->json([
            'data' => $activities,
        ]);
    }
}
