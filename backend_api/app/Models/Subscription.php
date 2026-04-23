<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Subscription extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'category_id',
        'name',
        'description',
        'provider',
        'billing_cycle',
        'custom_cycle_days',
        'amount',
        'currency',
        'start_date',
        'due_date',
        'next_due_date',
        'status',
        'payment_method',
        'reminder_days_before',
        'auto_renew',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'start_date' => 'date',
        'due_date' => 'date',
        'next_due_date' => 'date',
        'reminder_days_before' => 'integer',
        'custom_cycle_days' => 'integer',
        'auto_renew' => 'boolean',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function bills(): HasMany
    {
        return $this->hasMany(Bill::class);
    }

    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }
}
