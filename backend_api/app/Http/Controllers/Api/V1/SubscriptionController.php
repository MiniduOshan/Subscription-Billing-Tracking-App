<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Subscription;
use App\Repositories\SubscriptionRepository;
use App\Services\RecurringBillingService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SubscriptionController extends Controller
{
    public function __construct(
        private readonly SubscriptionRepository $subscriptionRepository,
        private readonly RecurringBillingService $recurringBillingService,
    ) {
    }

    public function index(Request $request): JsonResponse
    {
        $subscriptions = $this->subscriptionRepository->paginatedForUser($request->user()->id, $request->all());

        return response()->json($subscriptions);
    }

    public function store(Request $request): JsonResponse
    {
        $payload = $request->validate([
            'category_id' => ['nullable', 'exists:categories,id'],
            'name' => ['required', 'string', 'max:150'],
            'provider' => ['nullable', 'string', 'max:150'],
            'description' => ['nullable', 'string'],
            'billing_cycle' => ['required', 'in:weekly,monthly,yearly,custom'],
            'custom_cycle_days' => ['nullable', 'integer', 'min:1', 'max:3650'],
            'amount' => ['required', 'numeric', 'min:0'],
            'currency' => ['nullable', 'string', 'max:5'],
            'start_date' => ['nullable', 'date'],
            'due_date' => ['required', 'date'],
            'next_due_date' => ['nullable', 'date'],
            'status' => ['nullable', 'in:active,paused,cancelled'],
            'payment_method' => ['nullable', 'string', 'max:100'],
            'reminder_days_before' => ['nullable', 'integer', 'min:0', 'max:60'],
            'auto_renew' => ['nullable', 'boolean'],
        ]);

        $payload['currency'] = $payload['currency'] ?? 'USD';
        $subscription = $this->subscriptionRepository->createForUser($request->user()->id, $payload);

        $this->recurringBillingService->createInitialBillFromSubscription($subscription);

        return response()->json(['data' => $subscription->load('category')], 201);
    }

    public function show(Request $request, Subscription $subscription): JsonResponse
    {
        abort_if($subscription->user_id !== $request->user()->id, 403);

        return response()->json([
            'data' => $subscription->load(['category', 'bills', 'payments']),
        ]);
    }

    public function update(Request $request, Subscription $subscription): JsonResponse
    {
        abort_if($subscription->user_id !== $request->user()->id, 403);

        $payload = $request->validate([
            'category_id' => ['nullable', 'exists:categories,id'],
            'name' => ['sometimes', 'string', 'max:150'],
            'provider' => ['nullable', 'string', 'max:150'],
            'description' => ['nullable', 'string'],
            'billing_cycle' => ['sometimes', 'in:weekly,monthly,yearly,custom'],
            'custom_cycle_days' => ['nullable', 'integer', 'min:1', 'max:3650'],
            'amount' => ['sometimes', 'numeric', 'min:0'],
            'currency' => ['nullable', 'string', 'max:5'],
            'start_date' => ['nullable', 'date'],
            'due_date' => ['sometimes', 'date'],
            'next_due_date' => ['nullable', 'date'],
            'status' => ['sometimes', 'in:active,paused,cancelled'],
            'payment_method' => ['nullable', 'string', 'max:100'],
            'reminder_days_before' => ['nullable', 'integer', 'min:0', 'max:60'],
            'auto_renew' => ['nullable', 'boolean'],
        ]);

        $subscription->update($payload);

        return response()->json(['data' => $subscription->fresh()->load('category')]);
    }

    public function destroy(Request $request, Subscription $subscription): JsonResponse
    {
        abort_if($subscription->user_id !== $request->user()->id, 403);

        $subscription->delete();

        return response()->json(['message' => 'Subscription deleted']);
    }

    public function changeStatus(Request $request, Subscription $subscription): JsonResponse
    {
        abort_if($subscription->user_id !== $request->user()->id, 403);

        $payload = $request->validate([
            'status' => ['required', 'in:active,paused,cancelled'],
        ]);

        $subscription->update(['status' => $payload['status']]);

        return response()->json(['data' => $subscription->fresh()]);
    }
}
