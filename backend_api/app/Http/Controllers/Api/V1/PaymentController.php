<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Repositories\PaymentRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function __construct(private readonly PaymentRepository $paymentRepository)
    {
    }

    public function index(Request $request): JsonResponse
    {
        $payments = $this->paymentRepository->paginatedForUser($request->user()->id, $request->all());

        return response()->json($payments);
    }

    public function store(Request $request): JsonResponse
    {
        $payload = $request->validate([
            'subscription_id' => ['nullable', 'exists:subscriptions,id'],
            'bill_id' => ['nullable', 'exists:bills,id'],
            'amount' => ['required', 'numeric', 'min:0'],
            'currency' => ['nullable', 'string', 'max:5'],
            'payment_date' => ['required', 'date'],
            'payment_method' => ['nullable', 'string', 'max:100'],
            'notes' => ['nullable', 'string'],
            'receipt_reference' => ['nullable', 'string', 'max:255'],
        ]);

        $payment = Payment::create([
            ...$payload,
            'user_id' => $request->user()->id,
            'currency' => $payload['currency'] ?? 'USD',
        ]);

        return response()->json(['data' => $payment], 201);
    }

    public function show(Request $request, Payment $payment): JsonResponse
    {
        abort_if($payment->user_id !== $request->user()->id, 403);

        return response()->json(['data' => $payment->load(['subscription', 'bill'])]);
    }
}
