<?php

namespace App\Services;

use App\Models\Bill;
use App\Models\Subscription;
use Carbon\Carbon;

class RecurringBillingService
{
    public function createNextBillFromPaid(Bill $paidBill): ?Bill
    {
        if (! $paidBill->is_recurring || ! in_array($paidBill->billing_cycle, ['weekly', 'monthly', 'yearly', 'custom'], true)) {
            return null;
        }

        $nextDueDate = $this->calculateNextDate($paidBill->due_date, $paidBill->billing_cycle, $paidBill->custom_cycle_days);

        return Bill::create([
            'user_id' => $paidBill->user_id,
            'subscription_id' => $paidBill->subscription_id,
            'title' => $paidBill->title,
            'description' => $paidBill->description,
            'amount' => $paidBill->amount,
            'currency' => $paidBill->currency,
            'due_date' => $nextDueDate->toDateString(),
            'status' => 'upcoming',
            'is_recurring' => true,
            'billing_cycle' => $paidBill->billing_cycle,
            'custom_cycle_days' => $paidBill->custom_cycle_days,
            'payment_method' => $paidBill->payment_method,
            'notes' => null,
        ]);
    }

    public function createInitialBillFromSubscription(Subscription $subscription): Bill
    {
        $firstDueDate = Carbon::parse($subscription->next_due_date ?? $subscription->due_date ?? now()->toDateString());

        return Bill::create([
            'user_id' => $subscription->user_id,
            'subscription_id' => $subscription->id,
            'title' => $subscription->name,
            'description' => $subscription->description,
            'amount' => $subscription->amount,
            'currency' => $subscription->currency,
            'due_date' => $firstDueDate->toDateString(),
            'status' => $firstDueDate->isPast() ? 'overdue' : 'upcoming',
            'is_recurring' => true,
            'billing_cycle' => $subscription->billing_cycle,
            'custom_cycle_days' => $subscription->custom_cycle_days,
            'payment_method' => $subscription->payment_method,
            'notes' => null,
        ]);
    }

    public function calculateNextDate(string $fromDate, string $billingCycle, ?int $customCycleDays): Carbon
    {
        $date = Carbon::parse($fromDate);

        return match ($billingCycle) {
            'weekly' => $date->addWeek(),
            'monthly' => $date->addMonthNoOverflow(),
            'yearly' => $date->addYearNoOverflow(),
            'custom' => $date->addDays($customCycleDays ?? 30),
            default => $date->addMonthNoOverflow(),
        };
    }
}
