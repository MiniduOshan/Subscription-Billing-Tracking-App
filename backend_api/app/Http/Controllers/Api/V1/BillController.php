<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Bill;
use App\Models\Payment;
use App\Repositories\BillRepository;
use App\Services\RecurringBillingService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class BillController extends Controller
{
    public function __construct(
        private readonly BillRepository $billRepository,
        private readonly RecurringBillingService $recurringBillingService,
    ) {
    }

    public function index(Request $request): JsonResponse
    {
        $bills = $this->billRepository->paginatedForUser($request->user()->id, $request->all());

        return response()->json($bills);
    }

    public function store(Request $request): JsonResponse
    {
        $payload = $request->validate([
            'subscription_id' => ['nullable', 'exists:subscriptions,id'],
            'title' => ['required', 'string', 'max:150'],
            'description' => ['nullable', 'string'],
            'amount' => ['required', 'numeric', 'min:0'],
            'currency' => ['nullable', 'string', 'max:5'],
            'due_date' => ['required', 'date'],
            'status' => ['nullable', 'in:pending,paid,overdue,upcoming,cancelled'],
            'is_recurring' => ['nullable', 'boolean'],
            'billing_cycle' => ['nullable', 'in:weekly,monthly,yearly,custom'],
            'custom_cycle_days' => ['nullable', 'integer', 'min:1', 'max:3650'],
            'payment_method' => ['nullable', 'string', 'max:100'],
            'notes' => ['nullable', 'string'],
        ]);

        $bill = Bill::create([
            ...$payload,
            'user_id' => $request->user()->id,
            'currency' => $payload['currency'] ?? 'USD',
        ]);

        return response()->json(['data' => $bill], 201);
    }

    public function show(Request $request, Bill $bill): JsonResponse
    {
        abort_if($bill->user_id !== $request->user()->id, 403);

        return response()->json(['data' => $bill->load(['subscription', 'payments', 'reminders'])]);
    }

    public function update(Request $request, Bill $bill): JsonResponse
    {
        abort_if($bill->user_id !== $request->user()->id, 403);

        $payload = $request->validate([
            'title' => ['sometimes', 'string', 'max:150'],
            'description' => ['nullable', 'string'],
            'amount' => ['sometimes', 'numeric', 'min:0'],
            'currency' => ['nullable', 'string', 'max:5'],
            'due_date' => ['sometimes', 'date'],
            'status' => ['sometimes', 'in:pending,paid,overdue,upcoming,cancelled'],
            'is_recurring' => ['nullable', 'boolean'],
            'billing_cycle' => ['nullable', 'in:weekly,monthly,yearly,custom'],
            'custom_cycle_days' => ['nullable', 'integer', 'min:1', 'max:3650'],
            'payment_method' => ['nullable', 'string', 'max:100'],
            'notes' => ['nullable', 'string'],
        ]);

        $bill->update($payload);

        return response()->json(['data' => $bill->fresh()]);
    }

    public function destroy(Request $request, Bill $bill): JsonResponse
    {
        abort_if($bill->user_id !== $request->user()->id, 403);

        $bill->delete();

        return response()->json(['message' => 'Bill deleted']);
    }

    public function markPaid(Request $request, Bill $bill): JsonResponse
    {
        abort_if($bill->user_id !== $request->user()->id, 403);

        $payload = $request->validate([
            'payment_date' => ['nullable', 'date'],
            'amount' => ['nullable', 'numeric', 'min:0'],
            'payment_method' => ['nullable', 'string', 'max:100'],
            'notes' => ['nullable', 'string'],
            'receipt_reference' => ['nullable', 'string', 'max:255'],
        ]);

        $bill->update([
            'status' => 'paid',
            'paid_at' => now(),
            'payment_method' => $payload['payment_method'] ?? $bill->payment_method,
            'notes' => $payload['notes'] ?? $bill->notes,
        ]);

        $payment = Payment::create([
            'user_id' => $bill->user_id,
            'subscription_id' => $bill->subscription_id,
            'bill_id' => $bill->id,
            'amount' => $payload['amount'] ?? $bill->amount,
            'currency' => $bill->currency,
            'payment_date' => $payload['payment_date'] ?? now()->toDateString(),
            'payment_method' => $payload['payment_method'] ?? $bill->payment_method,
            'notes' => $payload['notes'] ?? null,
            'receipt_reference' => $payload['receipt_reference'] ?? null,
        ]);

        $nextBill = $this->recurringBillingService->createNextBillFromPaid($bill->fresh());

        return response()->json([
            'message' => 'Bill marked as paid',
            'data' => [
                'bill' => $bill->fresh(),
                'payment' => $payment,
                'next_bill' => $nextBill,
            ],
        ]);
    }

    public function snoozeReminder(Request $request, Bill $bill): JsonResponse
    {
        abort_if($bill->user_id !== $request->user()->id, 403);

        $payload = $request->validate([
            'hours' => ['required', 'integer', 'min:1', 'max:168'],
        ]);

        $reminder = $bill->reminders()->create([
            'user_id' => $request->user()->id,
            'type' => 'upcoming',
            'status' => 'snoozed',
            'remind_at' => now(),
            'snoozed_until' => now()->addHours((int) $payload['hours']),
        ]);

        return response()->json([
            'message' => 'Reminder snoozed',
            'data' => $reminder,
        ]);
    }
}
