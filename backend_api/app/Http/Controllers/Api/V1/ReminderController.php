<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Reminder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ReminderController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $reminders = Reminder::query()
            ->where('user_id', $request->user()->id)
            ->with('bill')
            ->orderBy('remind_at')
            ->paginate((int) $request->integer('per_page', 15));

        return response()->json($reminders);
    }

    public function update(Request $request, Reminder $reminder): JsonResponse
    {
        abort_if($reminder->user_id !== $request->user()->id, 403);

        $payload = $request->validate([
            'status' => ['nullable', 'in:pending,sent,snoozed,cancelled'],
            'snoozed_until' => ['nullable', 'date'],
        ]);

        $reminder->update($payload);

        return response()->json(['data' => $reminder->fresh()]);
    }
}
