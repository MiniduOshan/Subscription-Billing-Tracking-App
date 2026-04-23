<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Services\ReportService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function __construct(private readonly ReportService $reportService)
    {
    }

    public function monthlySpending(Request $request): JsonResponse
    {
        $months = min(max((int) $request->integer('months', 6), 1), 24);

        return response()->json([
            'data' => $this->reportService->monthlySpending($request->user()->id, $months),
        ]);
    }

    public function categorySpend(Request $request): JsonResponse
    {
        return response()->json([
            'data' => $this->reportService->categorySpend($request->user()->id),
        ]);
    }

    public function paidVsUnpaid(Request $request): JsonResponse
    {
        return response()->json([
            'data' => $this->reportService->statusBreakdown($request->user()->id),
        ]);
    }
}
